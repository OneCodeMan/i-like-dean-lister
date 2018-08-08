import Foundation
import UIKit

class XKCDComic: NSObject, Decodable, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(num ?? 0, forKey: "numNameKey")
        aCoder.encode(title ?? "", forKey: "titleNameKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "titleNameKey") as? String
        self.num = aDecoder.decodeObject(forKey: "numNameKey") as? Int
    }
    
    var month: String?
    var num: Int?
    var link: String?
    var year: String?
    var news: String?
    var safeTitle: String?
    var transcript: String?
    var alt: String?
    var img: String?
    var title: String?
    var day: String?
    
    private enum CodingKeys: String, CodingKey {
        case safeTitle = "safe_title"
        case month, num, link, year, news, transcript, alt, img, title, day
    }
    
}
