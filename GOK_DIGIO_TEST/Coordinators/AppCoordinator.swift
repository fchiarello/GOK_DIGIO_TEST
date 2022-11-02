import UIKit

protocol AppCoordinator: AnyObject {
    func addChildCoordinator(_ coordinator: AppCoordinator)
    func removeAllChildCoordinatorsWith<T>(type: T.Type)
    func removeAllChildCoordinators()
}

//final class AppCoordinator: Coordinator {
//    var childCoordinator = [Coordinator]()
//    var navigationController: UINavigationController
//
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//
//    func start() {
//        let vc = DigioServicesViewController()
//        navigationController.pushViewController(vc, animated: true)
//    }
//
//    func finish() {}
//}
