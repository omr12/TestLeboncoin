//
//  ProductListRepository.swift
//  TestLeboncoin
//
//  Created by Omar REDA on 02/05/2021.
//

import Foundation

protocol ProductListRepositoryProtocol {
    func getProductList(completion: @escaping ([Product]?) -> Void)
    func getCategoryList(completion: @escaping ([Category]?) -> Void)
}

class ProductListRepository: ProductListRepositoryProtocol {
    
    private let network = Network()
    
    func getProductList(completion: @escaping ([Product]?) -> Void) {
        let path = Endpoints.product.rawValue
        network.getItem(path, parameters: nil, completion: completion)
    }
    
    func getCategoryList(completion: @escaping ([Category]?) -> Void) {
        let path = Endpoints.category.rawValue
        network.getItem(path, parameters: nil, completion: completion)
    }
}
