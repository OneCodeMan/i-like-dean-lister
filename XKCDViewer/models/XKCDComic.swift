import Foundation
import UIKit

struct XKCDComic: Decodable {
    let month: String
    let num: Int
    let link: String
    let year: String
    let news: String
    let safeTitle: String
    let transcript: String
    let alt: String
    let img: String
    let title: String
    let day: String
    
    private enum CodingKeys: String, CodingKey {
        case safeTitle = "safe_title"
        case month, num, link, year, news, transcript, alt, img, title, day
    }
    
}
