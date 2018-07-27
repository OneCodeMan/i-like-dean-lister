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
            self.comicView.comic = currentComic
        }
        
        comicView.delegate = self
        
        view.backgroundColor = .white
        view.addSubview(comicView)
        comicView.snp.makeConstraints {
            $0.top.left.right.top.bottom.equalTo(0)
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
            self.comicView.comic = prevComic
            
            print(self.comic)
            
        }
    }
    
    @objc func handleNextClicked() {
        print("Next button clicked")
        
        session.getNextComic() { nextComic in
            self.comicView.comic = nextComic
            
            print(self.comic)
            
        }
    }
    
    @objc func handleRandomClicked() {
        print("Random button clicked")
        
        session.getRandomComic { randomComic in
            self.comicView.comic = randomComic
            
            print(self.comic)
        }
    }
    
    @objc func handleSelectedComicNumber(_ number: Int) {
        print("Comic Number clicked")
        
        let selectedComicNumber = number
        session.getComicWithNumber(of: selectedComicNumber) { comic in
            self.comicView.comic = comic
            
            print(self.comic)
        }
        
    }


}

