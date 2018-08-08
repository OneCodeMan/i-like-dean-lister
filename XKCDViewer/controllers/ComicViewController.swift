import UIKit
import SnapKit

class ComicViewController: UIViewController, ComicViewDelegate {
    
    var comicView = ComicView()
    let session = XKCDService.shared
    var isFavorite = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        session.getMostRecentComic { currentComic in
            self.comicView.comic = currentComic
        }
        
        comicView.delegate = self
        
        if let comic = comicView.comic {
            isFavorite = UserDefaults.standard.savedComics().contains(comic) ? true : false
        }
        
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
        
        // UI Favorites
        let favoriteImageName = isFavorite ? "notfavorite" : "favorite"
        isFavorite = !isFavorite
        comicView.toggleFavoriteButton.setImage(UIImage.init(named: favoriteImageName), for: .normal)
        
        // UserDefaults
        guard let comic = self.comicView.comic else { return }

        var comicList = UserDefaults.standard.savedComics()
        comicList.append(comic)
        let data = NSKeyedArchiver.archivedData(withRootObject: comicList)
        UserDefaults.standard.set(data, forKey: UserDefaults.favoritedComicKey)
        
        print(UserDefaults.standard.savedComics())
    }


}

