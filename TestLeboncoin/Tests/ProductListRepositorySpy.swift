//
//  ProductListRepositorySpy.swift
//  TestLeboncoin
//
//  Created by Omar REDA on 03/05/2021.
//

import Foundation

class ProductListRepositorySpy: ProductListRepositoryProtocol {
    
    private(set) var countGetCategoryList = 0
    private(set) var countGetProductList = 0
    
    var isProductFinished: (() -> Void)?
    var isCategoryFinished: (() -> Void)?

    func getCategoryList(completion: @escaping ([Category]?) -> Void) {
        countGetCategoryList += 1
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            completion([])
            self.isCategoryFinished?()
        }
    }
    
    func getProductList(completion: @escaping ([Product]?) -> Void) {
        countGetProductList += 1
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            let products = ProductListRepositoryHelper.products
            completion(products)
            self.isProductFinished?()
        }
    }
}
