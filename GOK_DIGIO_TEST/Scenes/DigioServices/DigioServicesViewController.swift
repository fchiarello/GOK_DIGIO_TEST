import UIKit

class DigioServicesViewController: UIViewController {
    
    private lazy var cashView: CashView = {
        let view = CashView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var spotlightCollection: SpotlightCollectionView = {
        let collectionView = SpotlightCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var productsCollection: ProductCollectionView = {
        let collectionView = ProductCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var coordinator: DigioServicesCoordinator?
    private var viewModel: DigioServicesViewModel
    
    init(coordinator: DigioServicesCoordinator? = nil,
         viewModel: DigioServicesViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.loadServices()
        viewModel.setupNavBar(navigationItem: self.navigationItem)
        view.backgroundColor = .white
    }
    
    @objc
    func cashBannerAction() {
        guard let cashModel = viewModel.cash else { return }
        let model = ServiceDetailModel(title: cashModel.title,
                                       imageURL: cashModel.bannerURL,
                                       description: cashModel.description)
        coordinator?.moveToDetail(model: model)
    }
}

extension DigioServicesViewController: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        view.addSubview(spotlightCollection)
        view.addSubview(cashView)
        view.addSubview(productsCollection)
    }
    
    func viewCodeConstraintSetup() {
        let padding: CGFloat = 16
        let maxPadding: CGFloat = 32
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            spotlightCollection.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding),
            spotlightCollection.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            spotlightCollection.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding),
            spotlightCollection.heightAnchor.constraint(equalToConstant: 150),
            
            cashView.topAnchor.constraint(equalTo: spotlightCollection.bottomAnchor, constant: padding),
            cashView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            cashView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding),
            cashView.heightAnchor.constraint(equalToConstant: 176),
            
            productsCollection.topAnchor.constraint(equalTo: cashView.bottomAnchor, constant: maxPadding),
            productsCollection.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            productsCollection.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding),
            productsCollection.heightAnchor.constraint(equalToConstant: 124)
        ])
    }
    
    func viewCodeAditionalSetup() {
        productsCollection.delegate = self
        spotlightCollection.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(cashBannerAction))
        cashView.addGestureRecognizer(gesture)
    }
}

extension DigioServicesViewController: DigioServicesViewModelDelegate {
    func successList() {
        let image = self.viewModel.setupCashImage() ?? UIImage()
        DispatchQueue.main.async {
            self.viewCodeSetup()
            self.cashView.setupView(title: self.viewModel.setupCashLabel(),
                                    image: image)
            self.productsCollection.model = self.viewModel.products
            self.spotlightCollection.model = self.viewModel.spotlights
        }
    }
    
    func errorList() {
        coordinator?.errorAlert(completion: reloadView)
    }
    
    func reloadView() {
        viewModel.loadServices()
    }
}

extension DigioServicesViewController: ProductCollectionViewDelegate {
    func productCollection(model: ServiceDetailModel) {
        coordinator?.moveToDetail(model: model)
    }
}

extension DigioServicesViewController: SpotlightCollectionViewDelegate {
    func spotlightCollection(model: ServiceDetailModel) {
        coordinator?.moveToDetail(model: model)
    }
}
