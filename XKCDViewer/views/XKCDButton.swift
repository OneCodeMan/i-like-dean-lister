import UIKit

class XKCDButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        self.backgroundColor = .buttonBackground
        self.titleLabel?.font = .helveticaNormal
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 6)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 1.0
        self.contentEdgeInsets = UIEdgeInsetsMake(5, 7, 5, 7)
    }

}
