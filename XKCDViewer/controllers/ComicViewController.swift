import UIKit
import SnapKit

class ComicViewController: UIViewController, ComicViewDelegate {
    
    var comicView = ComicView()
    let session = XKCDService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        session.getMostRecentComic { currentComic in
            self.comicView.comic = currentComic
        }
        
        comicView.delegate = self
        
    }
    
    // MARK:- Setting up view
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(comicView)
        comicView.snp.makeConstraints {
            $0.top.left.right.top.bottom.equalTo(0)
        }
    }
    
    // MARK:- Button handlers
    @objc func handleMostRecentClicked() {
        print("Most recent clicked")
        
        session.getMostRecentComic { mostRecentComic in
            self.comicView.comic = mostRecentComic
            
            
        }
    }
    
    @objc func handlePrevClicked() {
        print("Previous button clicked")
        
        session.getPrevComic() { prevComic in
            self.comicView.comic = prevComic
            
            
        }
    }
    
    @objc func handleNextClicked() {
        print("Next button clicked")
        
        session.getNextComic() { nextComic in
            self.comicView.comic = nextComic
            
            
        }
    }
    
    @objc func handleRandomClicked() {
        print("Random button clicked")
        
        session.getRandomComic { randomComic in
            self.comicView.comic = randomComic
            
        }
    }
    
    @objc func handleSelectedComicNumber(_ number: Int) {
        print("Comic Number clicked")
        
        let selectedComicNumber = number
        session.getComicWithNumber(of: selectedComicNumber) { comic in
            self.comicView.comic = comic
            
        }
        
    }
    
    @objc func handleToggleFavorite() {
        print("Favorite clicked")
        
        comicView.toggleFavoriteButton.setImage("notfavorite", for: .normal)
    }


}

