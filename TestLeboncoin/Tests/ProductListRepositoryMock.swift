//
//  ProductListRepositoryMock.swift
//  TestLeboncoin
//
//  Created by Omar REDA on 03/05/2021.
//

import Foundation

class ProductListRepositoryMock: ProductListRepositoryProtocol {
    func getCategoryList(completion: @escaping ([Category]?) -> Void) {
        let categories = ProductListRepositoryHelper.categories
        completion(categories)
    }
    
    func getProductList(completion: @escaping ([Product]?) -> Void) {
        let products = ProductListRepositoryHelper.products
        completion(products)
    }
}
