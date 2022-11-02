import UIKit

final class CashView: UIView {
    private lazy var cashTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cashImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewCodeSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(title: NSAttributedString, image: UIImage) {
        cashTitleLabel.attributedText = title
        cashImageView.image = image
    }
}

extension CashView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        addSubview(cashTitleLabel)
        addSubview(cashImageView)
    }
    
    func viewCodeConstraintSetup() {
        let topPadding: CGFloat = 8
        let padding: CGFloat = 16
        NSLayoutConstraint.activate([
            cashTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
            cashTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            cashTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            cashTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            cashImageView.topAnchor.constraint(equalTo: cashTitleLabel.bottomAnchor, constant: padding),
            cashImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cashImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cashImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
