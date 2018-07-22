import UIKit

class ViewController: UIViewController {
    
    var comic: XKCDComic?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        XKCDService.shared.fetchXKCDData(urlString: "https://xkcd.com/22/info.0.json") { (comic: XKCDComic) in
            self.comic = comic
            print(self.comic)
        }
    }


}

