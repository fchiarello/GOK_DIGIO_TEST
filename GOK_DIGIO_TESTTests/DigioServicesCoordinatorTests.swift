//
//  DigioServicesCoordinatorTests.swift
//  GOK_DIGIO_TESTTests
//
//  Created by Fellipe Ricciardi Chiarello on 11/2/22.
//

import XCTest
@testable import GOK_DIGIO_TEST

final class DigioServicesCoordinatorTests: XCTestCase {
    var coordinator: DigioServicesCoordinator?

    override func setUpWithError() throws {
        let factory = FactoryMock()
        coordinator = DigioServicesCoordinator(factory: factory)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    struct UnexpectedNilError: Error {}

    func testCoordinator() throws {
        let nav = UINavigationControllerMock()
        coordinator?.start(nav)
        guard (nav.pushedViewController as? DigioServicesViewController) != nil else {throw UnexpectedNilError() }
    }

}
