import XCTest
import SnapshotTesting
@testable import GOK_DIGIO_TEST

final class ServiceDetailViewsSnapshots: XCTestCase {
    var vc: ServiceDetailViewController?
    override func setUpWithError() throws {
        let factory = FactoryMock()
        let coordinator = DigioServicesCoordinator(factory: factory)
        let model = ServiceDetailModel(title: "TESTE", imageURL: "TESTE.com", description: "TESTE TESTE TESTE")
        let viewModel = factory.makeServicesDetailViewModel(model: model, coordinator: coordinator)
        
        vc = ServiceDetailViewController(coordinator: coordinator, viewModel: viewModel )
    }
    
    func testDetailControllerIPhoneX() {
        let result = verifySnapshot(matching: self.vc!,
                                     as: .image(on: .iPhoneX),
                                     named: "iPhoneX1   ",
                                     testName: "ServiceDetailVC")
        
        XCTAssertNil(result)
    }
    
    func testDetailControlleriPhoneXsMax() {
        let result = verifySnapshot(matching: self.vc!,
                                    as: .image(on: .iPhoneXsMax),
                                     named: "iPhoneXsMax",
                                     testName: "ServiceDetailVC")
        
        XCTAssertNil(result)
    }
    
    func testDetailControlleriPhoneSe() {
        let result = verifySnapshot(matching: self.vc!,
                                    as: .image(on: .iPhoneSe),
                                     named: "iPhoneSe",
                                     testName: "ServiceDetailVC")
        
        XCTAssertNil(result)
    }
}
