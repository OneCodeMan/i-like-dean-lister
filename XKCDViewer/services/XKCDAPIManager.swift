import Foundation
import UIKit

class XKCDService {
    static let shared = XKCDService()
    
    var maxComicNumber: Int?
    var urlString = ""
    var comicNumber: Int? {
        didSet {
            guard let updatedComicNumber = comicNumber else { return }
            urlString = "https://xkcd.com/\(updatedComicNumber)/info.0.json"
        }
    }
    
    private let mostRecentComic = "https://xkcd.com/info.0.json"
    
    init() {
        getMostRecentComic { (currentComic) in
            self.maxComicNumber = currentComic?.num
            self.comicNumber = currentComic?.num
        }
    }
    
    private func fetchXKCDData<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print("Failed to fetch home feed: ", err)
                return
            }
            
            guard let data = data else { return }
            do {
                let comicFeed = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(comicFeed)
                }
            } catch let jsonErr {
                print("Failed to serialize json: ", jsonErr)
            }
        }.resume()
    }
    
    func getMostRecentComic(completion: @escaping (XKCDComic?) -> Void) {
        comicNumber = maxComicNumber
        fetchXKCDData(urlString: mostRecentComic) { (mostRecentComic: XKCDComic) in
            completion(mostRecentComic)
        }
    }
    
    func getPrevComic(completion: @escaping (XKCDComic?) -> Void) {
        guard let currentComicNumber = comicNumber else { return }
        comicNumber = currentComicNumber == 1 ? maxComicNumber : currentComicNumber - 1
        fetchXKCDData(urlString: urlString) { (prevComic: XKCDComic) in
            completion(prevComic)
        }
    }
    
    func getNextComic(completion: @escaping (XKCDComic?) -> Void) {
        guard let currentComicNumber = comicNumber else { return }
        comicNumber = currentComicNumber == maxComicNumber ? 1 : currentComicNumber + 1
        fetchXKCDData(urlString: urlString) { (nextComic: XKCDComic) in
            completion(nextComic)
        }
    }
    
    func getComicWithNumber(of selectedComicNumber: Int, completion: @escaping (XKCDComic?) -> Void) {
        comicNumber = selectedComicNumber
        fetchXKCDData(urlString: urlString) { (comic: XKCDComic) in
            completion(comic)
        }
    }
    
    func getRandomComic(completion: @escaping (XKCDComic?) -> Void) {
        comicNumber = 40 //Int.random(in: 1..<maxComicNumber)
        fetchXKCDData(urlString: urlString) { (comic: XKCDComic) in
            completion(comic)
        }
    }
    
}
