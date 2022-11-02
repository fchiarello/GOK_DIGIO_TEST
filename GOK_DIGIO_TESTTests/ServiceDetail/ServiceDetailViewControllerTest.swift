import XCTest
@testable import GOK_DIGIO_TEST

final class ServiceDetailViewControllerTest: XCTestCase {
    var vc: ServiceDetailViewController?
    
    override func setUpWithError() throws {
        let factory = FactoryMock()
        let coordinator = DigioServicesCoordinator(factory: factory)
        let model = ServiceDetailModel(title: "TESTE", imageURL: "TESTE.com", description: "TESTE TESTE TESTE")
        let viewModel = factory.makeServicesDetailViewModel(model: model, coordinator: coordinator)
        
        vc = ServiceDetailViewController(coordinator: coordinator, viewModel: viewModel )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        vc?.viewDidLoad()
        
        XCTAssertNotNil(vc?.view.subviews, "Should Not be Nil")
    }
}
