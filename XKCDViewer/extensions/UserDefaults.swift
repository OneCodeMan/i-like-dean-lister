import Foundation

extension UserDefaults {
    
    static let favoritedComicKey = "favoritedComicKey"
    
    func savedComics() -> [XKCDComic] {
        guard let savedComicsData = UserDefaults.standard.data(forKey: UserDefaults.favoritedComicKey) else { return [] }
        guard let savedComics = NSKeyedUnarchiver.unarchiveObject(with: savedComicsData) as? [XKCDComic] else { return [] }
        return savedComics
    }
    
    func deleteComic(comic: XKCDComic) {
        let comics = savedComics()
        let filteredComics = comics.filter { (c) -> Bool in
            return c.title != comic.title && c.num != comic.num
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: filteredComics)
        UserDefaults.standard.set(data, forKey: UserDefaults.favoritedComicKey)
    }
    
    
}
