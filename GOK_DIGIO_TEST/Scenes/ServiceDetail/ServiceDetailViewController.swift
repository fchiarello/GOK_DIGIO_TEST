import UIKit

final class ServiceDetailViewController: UIViewController {
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel,
                                                  imageView,
                                                  descriptionLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
   
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textColor = .black
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    weak var coordinator: Coordinator?
    private var viewModel: ServiceDetailViewModel
    
    init(coordinator: Coordinator? = nil,
         viewModel: ServiceDetailViewModel) {
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
        viewModel.loadViewInformations()
        viewCodeSetup()
    }
    
}

extension ServiceDetailViewController: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        view.addSubview(mainStack)
    }
    
    func viewCodeConstraintSetup() {
        let safeArea = view.safeAreaLayoutGuide
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding),
            mainStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            mainStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 48),
            
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.centerXAnchor.constraint(equalTo: mainStack.centerXAnchor)
        ])
    }
    
    func viewCodeAditionalSetup() {
        view.backgroundColor = .systemMint
    }
}

extension ServiceDetailViewController: ServiceDetailViewModelDelegate {
    func loadImage(image: UIImage) {
        self.imageView.image = image
    }
    
    func loadLabels(title: String, description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
    
    func loadError() {
        coordinator?.errorAlert(completion: {
            self.viewModel.loadViewInformations()
        })
    }
}
