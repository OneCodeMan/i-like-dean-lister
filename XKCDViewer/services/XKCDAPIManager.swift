import Foundation
import UIKit

class XKCDService {
    static let shared = XKCDService()
    
    
    private let mostRecentComic = "https://xkcd.com/info.0.json"
    
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
        fetchXKCDData(urlString: mostRecentComic) { (mostRecentComic: XKCDComic) in
            completion(mostRecentComic)
        }
    }
    
    func getPrevComic(comicNumber: Int, completion: @escaping (XKCDComic?) -> Void) {
        var urlString = ""
        fetchXKCDData(urlString: mostRecentComic) { (prevComic: XKCDComic) in
            completion(prevComic)
        }
    }
    
}

/*
 How to use:
 
 let urlString = "https://api.letsbuildthatapp.com/youtube/course_detail?id=\(video.id)"
 Service.shared.fetchGenericData(urlString: urlString) { (courseDetails: [CourseDetails]) in
    self.courseDetails = courseDetails
    self.tableView.reloadData()
 }
 
 struct CourseDetails: Decodable {
     let name: String
     let duration: String
     let imageUrl: String
 }

 */
