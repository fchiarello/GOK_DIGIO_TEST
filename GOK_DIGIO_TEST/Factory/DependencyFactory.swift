import Foundation

protocol FactoryProtocol {
    var serviceManager: ServiceProtocol { get }
    
    func makeDigioServicesViewController(coordinator: DigioServicesCoordinator) -> DigioServicesViewController
    func makeDigioServicesViewModel(coordinator: Coordinator) -> DigioServicesViewModel
    func makeServicesDetailViewModel(model: ServiceDetailModel, coordinator: Coordinator) -> ServiceDetailViewModel
    func makeServicesDetailViewController(model: ServiceDetailModel, coordinator: Coordinator) -> ServiceDetailViewController
}

final class Factory: FactoryProtocol {
    var serviceManager: ServiceProtocol = Service()
    
    func makeDigioServicesViewController(coordinator: DigioServicesCoordinator) -> DigioServicesViewController {
        let viewModel = self.makeDigioServicesViewModel(coordinator: coordinator)
        let viewController = DigioServicesViewController(coordinator: coordinator,
                                                         viewModel: viewModel)
        return viewController
    }
    
    func makeDigioServicesViewModel(coordinator: Coordinator) -> DigioServicesViewModel {
        DigioServicesViewModel(coordinator: coordinator,
                               service: self.serviceManager)
    }
    
    func makeDigioServicesCoordinator() -> DigioServicesCoordinator {
        DigioServicesCoordinator(factory: self)
    }
}

extension Factory {
    func makeServicesDetailViewModel(model: ServiceDetailModel, coordinator: Coordinator) -> ServiceDetailViewModel {
        ServiceDetailViewModel(coordinator: coordinator,
                               model: model)
    }
    
    func makeServicesDetailViewController(model: ServiceDetailModel, coordinator: Coordinator) -> ServiceDetailViewController {
        let viewModel = self.makeServicesDetailViewModel(model: model,
                                                         coordinator: coordinator)
        let viewController = ServiceDetailViewController(coordinator: coordinator,
                                                         viewModel: viewModel)
        
        return viewController
    }
}

