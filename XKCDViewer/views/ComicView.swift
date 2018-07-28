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
            
            if let imageData = data {
                comicImageView.image = UIImage(data: imageData)
            } else {
                comicImageView.image = UIImage.init(named: "the_general_problem")
            }
            
            comicDateLabel.text = "\(comic.month)/\(comic.day)/\(comic.year)"
            comicTranscriptLabel.text = "\(comic.transcript)"
            
        }
    }
    
    public lazy var comicNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "#224"
        
        self.addSubview(label)
        return label
    }()
    
    public lazy var comicTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center

        label.text = "Communication"
        
        self.addSubview(label)
        return label
    }()
    
    public lazy var comicImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.init(named: "the_general_problem")
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        
        self.addSubview(image)
        return image
    }()
    
    public lazy var comicDateLabel: UILabel = {
        let label = UILabel()
        label.text = "7/17/2018"
        
        self.addSubview(label)
        return label
    }()
    
    public lazy var comicTranscriptLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        
        label.text = "Test transcript"
        
        self.addSubview(label)
        return label
    }()
    
    public lazy var prevButton: UIButton = {
        let button = UIButton()
        button.setTitle("Previous", for: .normal)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(handlePrevClicked(_:)), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    public lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(handleNextClicked(_:)), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    public lazy var randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Random", for: .normal)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(handleRandomClicked(_:)), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    public lazy var enterComicNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Or enter a comic number:"
        
        self.addSubview(label)
        return label
    }()
    
    public lazy var comicNumberTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .gray
        
        self.addSubview(textField)
        return textField
    }()
    
    public lazy var comicNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go to Comic", for: .normal)
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(handleSelectedComicNumber(_:)), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    public lazy var mostRecentComicButton: UIButton = {
        let button = UIButton()
        button.setTitle("Most Recent", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(handleMostRecentClicked(_:)), for: .touchUpInside)
        
        self.addSubview(button)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        comicNumberLabel.snp.makeConstraints {
            $0.top.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        
        comicTitleLabel.snp.makeConstraints {
            $0.top.equalTo(comicNumberLabel.snp.bottom).offset(5)
            $0.left.right.equalTo(0)
        }
        
        comicImageView.snp.makeConstraints {
            $0.top.equalTo(comicTitleLabel.snp.bottom).offset(5)
            $0.height.lessThanOrEqualTo(450)
            $0.left.right.equalTo(0)
        }
        
        comicDateLabel.snp.makeConstraints {
            $0.top.equalTo(comicImageView.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        comicTranscriptLabel.snp.makeConstraints {
            $0.top.equalTo(comicDateLabel.snp.bottom).offset(5)
            $0.height.lessThanOrEqualTo(100)
            $0.left.right.equalTo(0)
        }
        
        prevButton.snp.makeConstraints {
            $0.top.equalTo(comicTranscriptLabel.snp.bottom).offset(5)
            $0.left.equalTo(8)
            $0.width.lessThanOrEqualTo(100)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(comicTranscriptLabel.snp.bottom).offset(5)
            $0.right.equalTo(-8)
            $0.width.equalTo(prevButton)
        }
        
        randomButton.snp.makeConstraints {
            $0.top.equalTo(comicTranscriptLabel.snp.bottom).offset(5)
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
            $0.height.equalTo(50)
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
        guard let comicNumTextFieldInput = comicNumberTextField.text else { return }
        guard let selectedComicNumber = Int(comicNumTextFieldInput) else { return }
        delegate?.handleSelectedComicNumber(selectedComicNumber)
    }

}
