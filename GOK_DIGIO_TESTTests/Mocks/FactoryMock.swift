//
//  FactoryMock.swift
//  GOK_DIGIO_TESTTests
//
//  Created by Fellipe Ricciardi Chiarello on 11/2/22.
//

import Foundation
@testable import GOK_DIGIO_TEST

class FactoryMock: FactoryProtocol {
    var serviceManager: ServiceProtocol = Service()
    
    func makeDigioServicesViewController(coordinator: GOK_DIGIO_TEST.DigioServicesCoordinator) -> GOK_DIGIO_TEST.DigioServicesViewController {
        let viewModel = self.makeDigioServicesViewModel(coordinator: coordinator)
        let viewController = DigioServicesViewController(coordinator: coordinator,
                                                         viewModel: viewModel)
        return viewController
    }
    
    func makeDigioServicesViewModel(coordinator: GOK_DIGIO_TEST.Coordinator) -> GOK_DIGIO_TEST.DigioServicesViewModel {
        DigioServicesViewModel(coordinator: coordinator,
                               service: self.serviceManager)
    }
    
    func makeServicesDetailViewModel(model: GOK_DIGIO_TEST.ServiceDetailModel, coordinator: GOK_DIGIO_TEST.Coordinator) -> GOK_DIGIO_TEST.ServiceDetailViewModel {
        ServiceDetailViewModel(coordinator: coordinator,
                               model: model)
    }
    
    func makeServicesDetailViewController(model: GOK_DIGIO_TEST.ServiceDetailModel, coordinator: GOK_DIGIO_TEST.Coordinator) -> GOK_DIGIO_TEST.ServiceDetailViewController {
        let viewModel = self.makeServicesDetailViewModel(model: model,
                                                         coordinator: coordinator)
        let viewController = ServiceDetailViewController(coordinator: coordinator,
                                                         viewModel: viewModel)
        
        return viewController
    }
}
