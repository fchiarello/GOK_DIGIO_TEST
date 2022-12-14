import UIKit

public enum CollectionCellType {
    case spotlight
    case product
}

final class ServicesCollectionCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let iv = UIImageView(frame: contentView.frame)
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    } ()
    
    static let cellid = "ServicesCollectionCell"
    
    var height: CGFloat?
    var width: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(imageUrl: String, height: CGFloat, width: CGFloat) {
        self.height = height
        self.width = width
        viewCodeSetup()
        guard let url = URL(string: imageUrl) else {
            self.imageView.image = UIImage(named: Constants.errorImage)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.imageView.image = UIImage(named: Constants.errorImage)
            } else {
                guard let data = data else {
                    self.imageView.image = UIImage(named: Constants.errorImage)
                    return
                }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}

extension ServicesCollectionCell: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        contentView.addSubview(imageView)
    }
    
    func viewCodeConstraintSetup() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: height ?? .zero),
            imageView.widthAnchor.constraint(equalToConstant: width ?? .zero),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
