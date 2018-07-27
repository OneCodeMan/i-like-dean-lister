import UIKit

class ComicView: UIView {
    
    var delegate: ComicViewDelegate?
    var comic: XKCDComic?
    
    public lazy var view = UIView()

    public lazy var mostRecentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Most Recent", for: .normal)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(handleMostRecentClicked(_:)), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    public lazy var prevButton: UIButton = {
        let button = UIButton()
        button.setTitle("Previous", for: .normal)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(handlePrevClicked(_:)), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    public lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(handleNextClicked(_:)), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    public lazy var randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Random", for: .normal)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(handleRandomClicked(_:)), for: .touchUpInside)
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
        
        button.addTarget(self, action: #selector(handleSelectedComicNumber(_:)), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleMostRecentClicked(_ sender: Any) {
        delegate?.handleMostRecentClicked()
    }
    
    @objc func handlePrevClicked(_ sender: Any) {
        delegate?.handlePrevClicked()
    }
    
    @objc func handleNextClicked(_ sender: Any) {
        delegate?.handleNextClicked()
    }
    
    @objc func handleRandomClicked(_ sender: Any) {
        delegate?.handleRandomClicked()
    }
    
    @objc func handleSelectedComicNumber(_ sender: Any) {
        delegate?.handleSelectedComicNumber()
    }

}
