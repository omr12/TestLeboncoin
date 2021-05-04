//
//  ProductDetailsRepository.swift
//  TestLeboncoin
//
//  Created by Omar REDA on 04/05/2021.
//

import Foundation

protocol ProductDetailsRepositoryProtocol {
    func loadImageFromUrl(url: String, completion: @escaping (Data) -> Void)
}

class ProductDetailsRepository: ProductDetailsRepositoryProtocol {
    
    let network = Network()
    
    func loadImageFromUrl(url: String, completion: @escaping (Data) -> Void) {
        network.loadImageFromUrl(url: url) { (data) in
            completion(data)
        }
    }
}
