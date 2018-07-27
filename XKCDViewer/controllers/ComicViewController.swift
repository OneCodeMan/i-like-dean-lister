import UIKit
import SnapKit

class ComicViewController: UIViewController, ComicViewDelegate {
    
    var comic: XKCDComic?
    var comicView = ComicView()
    let session = XKCDService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        session.getMostRecentComic { currentComic in
            self.comic = currentComic
        }
        
        view.addSubview(comicView)
        comicView.snp.makeConstraints {
            $0.top.bottom.left.right.equalTo(0)
        }
        
    }
    
    @objc func handleMostRecentClicked() {
        print("Most recent clicked")
        
        session.getMostRecentComic { mostRecentComic in
            self.comic = mostRecentComic
            
            print(self.comic)
            
        }
    }
    
    @objc func handlePrevClicked() {
        print("Previous button clicked")
        
        session.getPrevComic() { prevComic in
            self.comic = prevComic
            
            print(self.comic)
            
        }
    }
    
    @objc func handleNextClicked() {
        print("Next button clicked")
        
        session.getNextComic() { nextComic in
            self.comic = nextComic
            
            print(self.comic)
            
        }
    }
    
    @objc func handleRandomClicked() {
        print("Random button clicked")
        
        session.getRandomComic { randomComic in
            self.comic = randomComic
            
            print(self.comic)
        }
    }
    
    @objc func handleSelectedComicNumber() {
        print("Comic Number clicked")
        
        let selectedComicNumber = 500
        session.getComicWithNumber(of: selectedComicNumber) { comic in
            self.comic = comic
            
            print(self.comic)
        }
        
    }


}

