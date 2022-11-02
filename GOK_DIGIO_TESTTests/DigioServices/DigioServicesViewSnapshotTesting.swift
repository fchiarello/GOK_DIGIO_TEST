import XCTest
import SnapshotTesting
@testable import GOK_DIGIO_TEST

final class DigioServicesViewSnapshotTesting: XCTestCase {
    var vc: DigioServicesViewController?
    override func setUpWithError() throws {
        let factory = FactoryMock()
        let coordinator = DigioServicesCoordinator(factory: factory)
        
        vc = DigioServicesViewController(coordinator: coordinator,
                                         viewModel: factory.makeDigioServicesViewModel(coordinator: coordinator))
    }
    
    func testDetailControllerIPhoneX() {
        let result = verifySnapshot(matching: self.vc!,
                                     as: .image(on: .iPhoneX),
                                     named: "iPhoneX1   ",
                                     testName: "DigioServicesVC")
        
        XCTAssertNil(result)
    }
    
    func testDetailControlleriPhoneXsMax() {
        let result = verifySnapshot(matching: self.vc!,
                                    as: .image(on: .iPhoneXsMax),
                                     named: "iPhoneXsMax",
                                     testName: "DigioServicesVC")
        
        XCTAssertNil(result)
    }
    
    func testDetailControlleriPhoneSe() {
        let result = verifySnapshot(matching: self.vc!,
                                    as: .image(on: .iPhoneSe),
                                     named: "iPhoneSe",
                                     testName: "DigioServicesVC")
        
        XCTAssertNil(result)
    }
}
