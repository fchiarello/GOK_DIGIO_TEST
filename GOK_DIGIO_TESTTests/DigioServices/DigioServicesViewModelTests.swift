//
//  DigioServicesViewModelTests.swift
//  GOK_DIGIO_TESTTests
//
//  Created by Fellipe Ricciardi Chiarello on 11/2/22.
//

import XCTest
@testable import GOK_DIGIO_TEST

final class DigioServicesViewModelTests: XCTestCase {
    var viewModel: DigioServicesViewModel?
    override func setUpWithError() throws {
        let factory = FactoryMock()
        let coordinator = DigioServicesCoordinator(factory: factory)
        viewModel = DigioServicesViewModel(coordinator: coordinator, service: ServiceMock())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModel() throws {
        viewModel?.loadServices()
        
        XCTAssertNotNil(viewModel?.cash, "Should not be nil")
        XCTAssertNotNil(viewModel?.spotlights, "Should not be nil")
        XCTAssertNotNil(viewModel?.products, "Should not be nil")
    }
}
