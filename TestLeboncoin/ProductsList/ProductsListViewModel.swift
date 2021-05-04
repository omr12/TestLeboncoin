//
//  ProductListViewModel.swift
//  TestLeboncoin
//
//  Created by Omar REDA on 02/05/2021.
//

import Foundation


class ProductListViewModel {
    
    var productsToShow = Observable<[Product]?>(value: nil)
    var products: [Product]?
    var categories: [Int: String]?
    
    var productsListRepository: ProductListRepositoryProtocol
    
    init(repository: ProductListRepositoryProtocol) {
        self.productsListRepository = repository
        self.getProductList()
    }
    
    private let sortMethod: (Product, Product) -> Bool = {
        p1, p2 in
        if p1.is_urgent == p2.is_urgent {
            return p1.creation_date ?? "" > p2.creation_date ?? ""
        } else {
            return (p1.is_urgent ?? false) ? true : false
        }
    }
    
    func sortedProducts(_ products: [Product]) -> [Product] {
        return products.sorted(by: sortMethod)
    }
    
    func getProductList() {
        productsListRepository.getCategoryList(completion: {
            categories in
            self.categories = [Int:String]()
            for category in categories ?? [] {
                self.categories?[category.id] = category.name
            }
            self.productsListRepository.getProductList { (products) in
                self.products = products
                for i in 0 ..< (self.products?.count ?? 0){
                    if let id = self.products?[i].category_id {
                        self.products?[i].categoryName = self.categories?[id]
                    }
                }
                self.productsToShow.value = self.sortedProducts(self.products ?? [])
            }
        })
    }
    
    func filterByCategory(_ id: Int) {
        self.productsToShow.value = products?
            .filter({ (product) -> Bool in
            product.category_id == id
        })
            .sorted(by: sortMethod)
        
    }
    
    func categoriesAsArray() -> [(Int, String)]{
        var array = [(Int, String)]()
        for (key, value) in categories ?? [Int:String]() {
            array.append((key, value))
        }
        return array
    }
    
}
