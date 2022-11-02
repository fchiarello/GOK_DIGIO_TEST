import UIKit

final class DigioServicesCoordinator: AppCoordinator {
    private(set) var childCoordinators: [AppCoordinator] = []
    weak var navigationController: UINavigationController?
    private var factory: FactoryProtocol
    
    init(factory: FactoryProtocol) {
        self.factory = factory
    }
    
    func addChildCoordinator(_ coordinator: AppCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

extension DigioServicesCoordinator: Coordinator {
    func start(_ navigationController: UINavigationController) {
        let vc = factory.makeDigioServicesViewController(coordinator: self)
        self.navigationController = navigationController
        navigationController.pushViewController(vc, animated: true)
    }
    
    func moveToDetail(model: ServiceDetailModel) {
        let vc = factory.makeServicesDetailViewController(model: model,
                                                          coordinator: self)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func errorAlert(completion: @escaping (() -> Void)) {
        
        let alert = UIAlertController(title: Constants.genericErrorTitle,
                                      message: Constants.genericErrorMessage,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Constants.genericErrorButtonTitle,
                                        style: .default) { _ in completion() }
        alert.addAction(alertAction)
        
        DispatchQueue.main.async {
            self.navigationController?.present(alert, animated: true)
        }
    }
}
