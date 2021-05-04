//
//  ProductListRepository.swift
//  TestLeboncoin
//
//  Created by Omar REDA on 02/05/2021.
//

import Foundation

protocol ProductListRepositoryProtocol {
    func getProductsList(completion: @escaping ([Product]?) -> Void)
    func getCategoryList(completion: @escaping ([Category]?) -> Void)
}

class ProductListRepository: ProductListRepositoryProtocol {
    
    let network = Network()
    
    func getProductsList(completion: @escaping ([Product]?) -> Void) {
        let path = "leboncoin/paperclip/master/listing.json"
        network.getItem(path, parameters: nil, completion: completion)
    }
    
    func getCategoryList(completion: @escaping ([Category]?) -> Void) {
        let path = "leboncoin/paperclip/master/categories.json"
        network.getItem(path, parameters: nil, completion: completion)
    }
}

class ProductsListRepositoryHelper {
    
    static let products = [
        Product(category_id: 1, title: "Aspirateur", description: "desc1", price: 100, creation_date: "2019-11-05T20:04:15+0000", is_urgent: false, images_url: ImageURL(small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/03a6fbefd4a0eead4c6bd7497e405d39b479bdc6.jpg", thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/03a6fbefd4a0eead4c6bd7497e405d39b479bdc6.jpg"), categoryName: nil),
        Product(category_id: 3, title: "Telephone", description: "desc2", price: 600, creation_date: "2019-11-03T20:04:15+0000", is_urgent: false, images_url: ImageURL(small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/03a6fbefd4a0eead4c6bd7497e405d39b479bdc6.jpg", thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/03a6fbefd4a0eead4c6bd7497e405d39b479bdc6.jpg"), categoryName: nil),
        Product(category_id: 6, title: "roue de secours", description: "desc3", price: 60, creation_date: "2019-11-09T20:04:15+0000", is_urgent: true, images_url: ImageURL(small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/03a6fbefd4a0eead4c6bd7497e405d39b479bdc6.jpg", thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/03a6fbefd4a0eead4c6bd7497e405d39b479bdc6.jpg"), categoryName: nil)
    ]
    
    static let categories = [
        Category(id: 1, name: "Vehicule"),
        Category(id: 2, name: "Mode"),
        Category(id: 3, name: "Bricolage"),
        Category(id: 4, name: "Maison"),
        Category(id: 5, name: "Loisirs"),
        Category(id: 6, name: "Immobilier"),
    ]
    
    static let categoriesTuples = [
        (1, "Vehicule"),
        (2, "Mode"),
        (3, "Bricolage"),
        (4, "Maison"),
        (5, "Loisirs"),
        (6, "Immobilier"),

    ]
    
    static let categoriesDict = [1:"Vehicule",
                                 2:"Mode",
                                 3:"Bricolage",
                                 4:"Maison",
                                 5:"Loisirs",
                                 6:"Immobilier"]
    
    static let sortedProducts = [
        Product(category_id: 6, title: "roue de secours", description: "desc3", price: 60, creation_date: "2019-11-09T20:04:15+0000", is_urgent: true, images_url: ImageURL(small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/03a6fbefd4a0eead4c6bd7497e405d39b479bdc6.jpg", thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/03a6fbefd4a0eead4c6bd7497e405d39b479bdc6.jpg"), categoryName: nil),
        Product(category_id: 1, title: "Aspirateur", description: "desc1", price: 100, creation_date: "2019-11-05T20:04:15+0000", is_urgent: false, images_url: ImageURL(small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/03a6fbefd4a0eead4c6bd7497e405d39b479bdc6.jpg", thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/03a6fbefd4a0eead4c6bd7497e405d39b479bdc6.jpg"), categoryName: nil),
        Product(category_id: 3, title: "Telephone", description: "desc2", price: 600, creation_date: "2019-11-03T20:04:15+0000", is_urgent: false, images_url: ImageURL(small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/03a6fbefd4a0eead4c6bd7497e405d39b479bdc6.jpg", thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/03a6fbefd4a0eead4c6bd7497e405d39b479bdc6.jpg"), categoryName: nil)
    ]
}

class ProductsListRepositoryMock: ProductListRepositoryProtocol {
    func getCategoryList(completion: @escaping ([Category]?) -> Void) {
        let categories = ProductsListRepositoryHelper.categories
        completion(categories)
    }
    
    func getProductsList(completion: @escaping ([Product]?) -> Void) {
        let products = ProductsListRepositoryHelper.products
        completion(products)
    }
}

class ProductsListRepositorySpy: ProductListRepositoryProtocol {
    
    private(set) var countGetCategoryList = 0
    private(set) var countGetProductsList = 0
    
    var isFinished: (() -> Void)?
    
    func getCategoryList(completion: @escaping ([Category]?) -> Void) {
        countGetCategoryList += 1
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            completion([])
        }
    }
    
    func getProductsList(completion: @escaping ([Product]?) -> Void) {
        countGetProductsList += 1
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            let products = ProductsListRepositoryHelper.products
            completion(products)
            self.isFinished?()
        }
    }
}
