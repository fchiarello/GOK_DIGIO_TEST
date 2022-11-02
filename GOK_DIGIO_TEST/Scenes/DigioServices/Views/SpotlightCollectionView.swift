import UIKit

protocol SpotlightCollectionViewDelegate: AnyObject {
    func spotlightCollection(model: ServiceDetailModel)
}

final class SpotlightCollectionView: UIView {
    
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
    
    public var model: [Spotlight]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var delegate: SpotlightCollectionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewCodeSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SpotlightCollectionView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        addSubview(collectionView)
    }
    
    func viewCodeConstraintSetup() {
        let topPadding: CGFloat = 8
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func viewCodeAditionalSetup() {
        collectionView.setupShadow()
    }
}

extension SpotlightCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = model else { return }
        let detailModel = ServiceDetailModel(title: model[indexPath.item].name,
                                             imageURL: model[indexPath.item].bannerURL,
                                             description: model[indexPath.item].description)
        delegate?.spotlightCollection(model: detailModel)
    }
}

extension SpotlightCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServicesCollectionCell.cellid, for: indexPath)
       
        let collectionCell = cell as? ServicesCollectionCell

        guard
            let collectionViewCell = collectionCell
        else { return UICollectionViewCell() }
        
        let url = model?[indexPath.row].bannerURL ?? String()
        collectionViewCell.setupCell(imageUrl: url, height: 150, width: 300)
        return collectionViewCell
    }
}

extension SpotlightCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 300, height: 150)
    }
}
