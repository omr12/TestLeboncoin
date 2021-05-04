//
//  ProductTests.swift
//  TestLeboncoinTests
//
//  Created by Omar REDA on 04/05/2021.
//

import XCTest
@testable import TestLeboncoin

class ProductTests: XCTestCase {

    var sut: Product!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ProductHelper.product
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_dateTextShouldBeCorrect() throws {
        XCTAssertEqual(sut.dateText, "05/11/2019")
    }
    
    func test_priceTextShouldBeCorrect() throws {
        XCTAssertEqual(sut.priceText, "100.00 €")
    }
    
    func test_dateShouldBeCorrect() throws {
        let calendar = Calendar.current
        let expectedDate = calendar.date(from: DateComponents(year:2019, month:11, day: 05, hour: 16, minute: 56, second: 59))
        XCTAssertEqual(sut.date, expectedDate)
    }

}
