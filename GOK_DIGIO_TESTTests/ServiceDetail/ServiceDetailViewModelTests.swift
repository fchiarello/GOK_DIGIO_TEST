import XCTest
@testable import GOK_DIGIO_TEST

final class ServiceDetailViewModelTests: XCTestCase {

    var viewModel: ServiceDetailViewModel?
    var success: Bool?
    
    override func setUpWithError() throws {
        let factory = FactoryMock()
        let coordinator = DigioServicesCoordinator(factory: factory)
        
        viewModel = ServiceDetailViewModel(coordinator: coordinator)
        viewModel?.delegate = self
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessViewModel() throws {
        viewModel?.model = ServiceDetailModel(title: "TESTE", imageURL: "TESTE.com", description: "TESTE TESTE TESTE")
        viewModel?.loadViewInformations()
        XCTAssert(success == true, "Should load Image and labels")
    }
    
    func testErrorViewModel() throws {
        viewModel?.model = nil
        viewModel?.loadViewInformations()
        XCTAssert(success == false, "Should load Error")
    }
}

extension ServiceDetailViewModelTests: ServiceDetailViewModelDelegate {
    func loadImage(image: UIImage) {
        success = true
    }
    
    func loadLabels(title: String, description: String) {
        success = true
    }
    
    func loadError() {
        success = false
    }
}
