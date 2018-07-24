import UIKit

class ViewController: UIViewController {
    
    var comic: XKCDComic?
    var maxComicNumber: Int?
    var comicNumber = 1943
    let session = XKCDService.shared
    
    public lazy var mostRecentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Most Recent", for: .normal)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(handleMostRecentClicked), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    public lazy var prevButton: UIButton = {
        let button = UIButton()
        button.setTitle("Previous", for: .normal)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(handlePrevClicked), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    public lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(handleNextClicked), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    public lazy var randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Random", for: .normal)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(handleRandomClicked), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    public lazy var comicNumberTextField: UITextField = {
       let textField = UITextField()
        
        
        view.addSubview(textField)
        return textField
    }()
    
    public lazy var comicNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go to Comic", for: .normal)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(handleComicNumberClicked), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        session.getMostRecentComic { currentComic in
            self.comic = currentComic
            self.comicNumber = currentComic?.num ?? 0
            self.maxComicNumber = currentComic?.num ?? 0
            //print(self.comic)
        }
        
    }
    
    func setupView() {
        
        mostRecentButton.translatesAutoresizingMaskIntoConstraints = false
        mostRecentButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        mostRecentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        mostRecentButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        mostRecentButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.topAnchor.constraint(equalTo: mostRecentButton.topAnchor, constant: 100).isActive = true
        prevButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        prevButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        prevButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.topAnchor.constraint(equalTo: prevButton.bottomAnchor, constant: 10).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        randomButton.translatesAutoresizingMaskIntoConstraints = false
        randomButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 10).isActive = true
        randomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        randomButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        randomButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        comicNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        comicNumberTextField.topAnchor.constraint(equalTo: randomButton.bottomAnchor, constant: 10).isActive = true
        comicNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        comicNumberTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        comicNumberTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        comicNumberButton.translatesAutoresizingMaskIntoConstraints = false
        comicNumberButton.topAnchor.constraint(equalTo: comicNumberTextField.bottomAnchor, constant: 10).isActive = true
        comicNumberButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        comicNumberButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        comicNumberButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
    }
    
    @objc func handleMostRecentClicked() {
        print("Most recent clicked")
        
        session.getMostRecentComic { mostRecentComic in
            self.comic = mostRecentComic
            self.comicNumber = mostRecentComic?.num ?? 0
            
            print(self.comic)
            
        }
    }
    
    @objc func handlePrevClicked() {
        print("Previous button clicked")
        
        session.getPrevComic(currentComicNumber: comicNumber) { prevComic in
            self.comic = prevComic
            self.comicNumber = self.comicNumber - 1
            
            print(self.comic)
            
        }
    }
    
    @objc func handleNextClicked() {
        print("Next button clicked")
        
        if comicNumber == maxComicNumber {
            comicNumber = 0
        }
        
        session.getNextComic(currentComicNumber: comicNumber) { nextComic in
            self.comic = nextComic
            self.comicNumber = self.comicNumber + 1
            
            print(self.comic)
            
        }
    }
    
    @objc func handleRandomClicked() {
        print("Random button clicked")
        
        // TODO
    }
    
    @objc func handleComicNumberClicked() {
        guard let selectedComicNumber = Int(comicNumberTextField.text!) else { return }
        print("Comic Number clicked")
        session.getComicWithNumber(of: selectedComicNumber) { comic in
            self.comic = comic
            self.comicNumber = selectedComicNumber
            
            print(self.comic)
        }
        
    }
    



}

