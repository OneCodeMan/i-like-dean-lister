import UIKit
import SnapKit

class ComicView: UIView {
    
    var delegate: ComicViewDelegate?
    var comic: XKCDComic? {
        didSet {
            guard let comic = comic else { return }
            comicNumberLabel.text = "#\(comic.num)"
            comicTitleLabel.text = "\(comic.title)"
            
            let url = URL(string: comic.img)!
            let data = try? Data(contentsOf: url)
            
            comicImageScrollView.zoomScale = 1.0
            if let imageData = data {
                comicImageView.image = UIImage(data: imageData)
            } else {
                comicImageView.image = UIImage.init(named: "the_general_problem")
            }
            
            comicDateLabel.text = "\(comic.month)/\(comic.day)/\(comic.year)"
            
        }
    }
    
    var isFavorite: Bool?
    
    // MARK:- View components
    lazy var comicNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "#224"
        label.font = .helveticaItalic
        
        self.addSubview(label)
        return label
    }()
    
    lazy var toggleFavoriteButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage.init(named: "notfavorite")
        button.addTarget(self, action: #selector(handleToggleFavorite(_:)), for: .touchUpInside)
        button.setTitle("Favorite", for: .normal)
        button.setImage(buttonImage, for: .normal)
        
        self.addSubview(button)
        return button
    }()
    
    lazy var comicTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Communication"
        label.font = .helveticaBold
        
        self.addSubview(label)
        return label
    }()
    
    lazy var comicImageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        self.addSubview(scrollView)
        return scrollView
    }()
    
    lazy var comicImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.init(named: "the_general_problem")
        image.contentMode = .scaleAspectFit
        
        comicImageScrollView.addSubview(image)
        return image
    }()
    
    lazy var comicDateLabel: UILabel = {
        let label = UILabel()
        label.text = "7/17/2018"
        label.font = .helveticaLight
        
        self.addSubview(label)
        return label
    }()
    
    lazy var prevButton: XKCDButton = {
        let button = XKCDButton()
        button.setTitle("Previous", for: .normal)
        
        button.addTarget(self, action: #selector(handlePrevClicked(_:)), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    lazy var nextButton: XKCDButton = {
        let button = XKCDButton()
        button.setTitle("Next", for: .normal)
        
        button.addTarget(self, action: #selector(handleNextClicked(_:)), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    lazy var randomButton: XKCDButton = {
        let button = XKCDButton()
        button.setTitle("Random", for: .normal)
        
        button.addTarget(self, action: #selector(handleRandomClicked(_:)), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    lazy var enterComicNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Or enter a comic number:"
        
        self.addSubview(label)
        return label
    }()
    
    lazy var comicNumberTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .background
        textField.layer.shadowColor = UIColor.buttonBackground.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 6)
        textField.layer.shadowRadius = 3
        textField.layer.shadowOpacity = 1.0
        
        self.addSubview(textField)
        return textField
    }()
    
    lazy var comicNumberButton: XKCDButton = {
        let button = XKCDButton()
        button.setTitle("Go to Comic", for: .normal)
        
        button.addTarget(self, action: #selector(handleSelectedComicNumber(_:)), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    lazy var mostRecentComicButton: XKCDButton = {
        let button = XKCDButton()
        button.setTitle("Recent", for: .normal)
        
        button.addTarget(self, action: #selector(handleMostRecentClicked(_:)), for: .touchUpInside)
        
        self.addSubview(button)
        return button
    }()
    
    // MARK:- Init functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(ComicView.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ComicView.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    // MARK:- Keyboard toggle handlers
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.frame.origin.y == 0 {
                self.frame.origin.y =  self.frame.origin.y - keyboardSize.height - (comicImageView.image?.size.height)! / 2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.frame.origin.y != 0 {
                self.frame.origin.y = self.frame.origin.y + keyboardSize.height + (comicImageView.image?.size.height)! / 2
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Set up view
    func setupView() {
        var comicMaxHeight = 0
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                comicMaxHeight = 200
            default:
                comicMaxHeight = 400
            }
        }
        
        comicImageScrollView.delegate = self
        comicImageScrollView.minimumZoomScale = 1.0
        comicImageScrollView.maximumZoomScale = 10.0
        
        comicNumberLabel.snp.makeConstraints {
            $0.top.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        
        toggleFavoriteButton.snp.makeConstraints {
            $0.top.equalTo(comicNumberLabel)
            $0.left.equalTo(comicNumberLabel.snp.right).offset(5)
        }
        
        comicTitleLabel.snp.makeConstraints {
            $0.top.equalTo(comicNumberLabel.snp.bottom).offset(5)
            $0.left.right.equalTo(0)
        }
        
        comicImageScrollView.snp.makeConstraints {
            $0.top.equalTo(comicTitleLabel.snp.bottom).offset(5)
            $0.height.lessThanOrEqualTo(comicMaxHeight)
            $0.left.equalTo(1)
            $0.right.equalTo(-1)
        }
        
        comicImageView.snp.makeConstraints {
            $0.height.equalTo(comicImageScrollView)
            $0.width.equalTo(comicImageScrollView)
        }
        
        comicDateLabel.snp.makeConstraints {
            $0.top.equalTo(comicImageScrollView.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        prevButton.snp.makeConstraints {
            $0.top.equalTo(comicDateLabel.snp.bottom).offset(5)
            $0.left.equalTo(8)
            $0.width.lessThanOrEqualTo(100)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(comicDateLabel.snp.bottom).offset(5)
            $0.right.equalTo(-8)
            $0.width.equalTo(prevButton)
        }
        
        randomButton.snp.makeConstraints {
            $0.top.equalTo(comicDateLabel.snp.bottom).offset(5)
            $0.left.equalTo(prevButton.snp.right).offset(5)
            $0.right.equalTo(nextButton.snp.left).offset(-5)
            $0.width.equalTo(prevButton)
        }
        
        enterComicNumberLabel.snp.makeConstraints {
            $0.top.equalTo(prevButton.snp.bottom).offset(5)
            $0.left.equalTo(8)
        }
        
        comicNumberTextField.snp.makeConstraints {
            $0.top.equalTo(enterComicNumberLabel.snp.bottom).offset(5)
            $0.left.equalTo(8)
            $0.width.equalTo(100)
            $0.height.equalTo(35)
        }
        
        comicNumberButton.snp.makeConstraints {
            $0.top.equalTo(enterComicNumberLabel.snp.bottom).offset(5)
            $0.left.equalTo(comicNumberTextField.snp.right).offset(15)
        }
        
        mostRecentComicButton.snp.makeConstraints {
            $0.top.equalTo(enterComicNumberLabel.snp.bottom).offset(5)
            $0.left.equalTo(comicNumberButton.snp.right).offset(5)
        }
    }
    
    // MARK:- Button click functions
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
        guard let comicNumTextFieldInput = comicNumberTextField.text else { return }
        guard let selectedComicNumber = Int(comicNumTextFieldInput) else { return }
        delegate?.handleSelectedComicNumber(selectedComicNumber)
    }
    
    @objc func handleToggleFavorite(_ sender: Any) {
        delegate?.handleToggleFavorite()
    }
    
    // MARK:- Keyboard logic
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }

}

// MARK:- UIScrollViewDelegate
extension ComicView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.comicImageView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 && scrollView.zoomScale == 1.0 {
            scrollView.contentOffset.x = 0
        }
        
        if scrollView.contentOffset.y != 0 && scrollView.zoomScale == 1.0 {
            scrollView.contentOffset.y = 0
        }
    }
}
