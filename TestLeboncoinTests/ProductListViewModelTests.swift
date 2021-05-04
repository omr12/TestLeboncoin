//
//  TestLeboncoinTests.swift
//  TestLeboncoinTests
//
//  Created by Omar REDA on 28/04/2021.
//

import XCTest
@testable import TestLeboncoin

class ProductListViewModelTests: XCTestCase {
    
    var sut: ProductListViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ProductListViewModel(repository: ProductListRepositoryMock())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_whenInitViewModel_getCategoryListShouldBeCalledOnce() throws {
        let spy = ProductListRepositorySpy()
        _ = ProductListViewModel(repository: spy)
        XCTAssertEqual(spy.countGetCategoryList, 1)
    }
    
    func test_whenInitViewModel_getProductListShouldBeCalledOnce() throws {
        let expec = expectation(description: "test_whenInitViewModel_getProductListShouldBeCalledOnce")
        let spy = ProductListRepositorySpy()
        _ = ProductListViewModel(repository: spy)
        spy.isProductFinished = {
            expec.fulfill()
        }
        wait(for: [expec], timeout: 5)
        XCTAssertEqual(spy.countGetProductList, 1)
    }
    
    func test_whenInitViewModel_productsIsNotNil() throws {
        let expec = expectation(description: "test_whenInitViewModel_productsIsNotNil")
        let spy = ProductListRepositorySpy()
        let sut2 = ProductListViewModel(repository: spy)
        spy.isProductFinished = {
            expec.fulfill()
        }
        wait(for: [expec], timeout: 5)
        XCTAssertNotNil(sut2.products)
    }
    
    func test_whenInitViewModel_productsShouldBeCorrect() throws {
        let expec = expectation(description: "test_whenInitViewModel_productsShouldBeCorrect")
        let spy = ProductListRepositorySpy()
        let sut2 = ProductListViewModel(repository: spy)
        spy.isProductFinished = {
            expec.fulfill()
        }
        wait(for: [expec], timeout: 5)
        let expectedProducts = ProductListRepositoryHelper.products
        XCTAssertEqual(sut2.products, expectedProducts)
    }
    
    func test_whenFilteringByOne_allProductsCategoryShouldBeOne() throws {
        sut.filterByCategory(1)
        for product in sut.productsToShow.value ?? [] {
            if product.category_id != 1 {
                XCTFail()
            }
        }
        XCTAssertNotNil(sut.products)
    }
    
    func test_whenCallingCategoriesAsArray_shouldReturnArray() throws {
        sut.categories = ProductListRepositoryHelper.categoriesDict
        let array = sut.categoriesAsArray()
        let expectedArray = ProductListRepositoryHelper.categoriesTuples
        XCTAssertEqual(array.count, expectedArray.count)
    }
}
