//
//  DigioServicesViewControllerTest.swift
//  GOK_DIGIO_TESTTests
//
//  Created by Fellipe Ricciardi Chiarello on 11/2/22.
//

import XCTest
@testable import GOK_DIGIO_TEST

final class DigioServicesViewControllerTest: XCTestCase {
    var vc: DigioServicesViewController?
    override func setUpWithError() throws {
        let factory = FactoryMock()
        let coordinator = DigioServicesCoordinator(factory: factory)
        
        vc = DigioServicesViewController(coordinator: coordinator,
                                         viewModel: factory.makeDigioServicesViewModel(coordinator: coordinator))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testVC() throws {
        vc?.viewDidLoad()
        
        XCTAssertNotNil(vc?.view.subviews, "Should Not be Nil")
        XCTAssertNotNil(vc?.navigationItem.titleView, "Should Not be Nil")
    }

}
