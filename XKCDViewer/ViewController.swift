import UIKit

class ViewController: UIViewController {
    
    var comic: XKCDComic?
    var comicUrl: String?
    var currentComic = 1943
    var currentComicUrl = "https://xkcd.com/info.0.json"
    
    public lazy var prevButton: UIButton = {
        let button = UIButton()
        button.setTitle("Previous", for: .normal)
        button.backgroundColor = .black
        view.addSubview(button)
        return button
    }()
    
    public lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .black
        view.addSubview(button)
        return button
    }()
    
    public lazy var randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Random", for: .normal)
        button.backgroundColor = .black
        view.addSubview(button)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        comicUrl = "https://xkcd.com/\(currentComic)/info.0.json"
        handleServiceCall(urlString: currentComicUrl)
        
        setupView()
        
    }
    
    func setupView() {
        
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
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
    }
    
    func handleServiceCall(urlString: String) {
        XKCDService.shared.fetchXKCDData(urlString: urlString) { (comic: XKCDComic) in
            self.comic = comic
            print(self.comic)
            
            // UI would happen here
            
        }
        
    }


}

