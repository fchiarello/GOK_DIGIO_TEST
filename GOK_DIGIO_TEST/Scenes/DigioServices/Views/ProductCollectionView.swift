import UIKit

protocol ProductCollectionViewDelegate: AnyObject {
    func productCollection(model: ServiceDetailModel)
}

final class ProductCollectionView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.text = Constants.productTitle
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: frame,
                                          collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .none
        collection.layer.cornerRadius = 8
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ServicesCollectionCell.self,
                            forCellWithReuseIdentifier: ServicesCollectionCell.cellid)
        return collection
    }()
    
    var model: [Product]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var delegate: ProductCollectionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewCodeSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductCollectionView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        addSubview(titleLabel)
        addSubview(collectionView)
    }
    
    func viewCodeConstraintSetup() {
        let topPadding: CGFloat = 8
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func viewCodeAditionalSetup() {
        collectionView.setupShadow()
    }
}

extension ProductCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = model else { return }
        let detailModel = ServiceDetailModel(title: model[indexPath.item].name,
                                       imageURL: model[indexPath.item].imageURL,
                                       description: model[indexPath.item].description)
        delegate?.productCollection(model: detailModel)
    }
}

extension ProductCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        model?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServicesCollectionCell.cellid, for: indexPath)
       
        let collectionCell = cell as? ServicesCollectionCell

        guard
            let collectionViewCell = collectionCell
        else { return UICollectionViewCell() }
        
        let url = model?[indexPath.row].imageURL ?? String()
        collectionViewCell.setupCell(imageUrl: url, height: 80, width: 80)
        return collectionViewCell
    }
}

extension ProductCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 80, height: 80)
    }
}
