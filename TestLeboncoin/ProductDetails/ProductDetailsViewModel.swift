//
//  ProductDetailsViewModel.swift
//  TestLeboncoin
//
//  Created by Omar REDA on 02/05/2021.
//

import Foundation

class ProductDetailsViewModel {
    
    var product: Product? {
        didSet {
            getProductImageData()
        }
    }
    var repository: ProductDetailsRepositoryProtocol
    
    var productImageData = Observable<Data?>(value: nil)
    
    init(repository: ProductDetailsRepositoryProtocol = ProductDetailsRepository()) {
        self.repository = repository
    }
    
    func getProductImageData() {
        repository.loadImageFromUrl(url: product?.images_url?.thumb ?? "") { (data) in
            self.productImageData.value = data
        }
    }
}
