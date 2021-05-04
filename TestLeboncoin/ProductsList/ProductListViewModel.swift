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
    
    private var productListRepository: ProductListRepositoryProtocol
    
    init(repository: ProductListRepositoryProtocol = ProductListRepository()) {
        self.productListRepository = repository
        self.getProductsAndCategories()
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
    
    func getProductsAndCategories() {
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        dispatchGroup.enter()
        
        getProductList(dispatchGroup: dispatchGroup)
        getCategoryList(dispatchGroup: dispatchGroup)
        
        dispatchGroup.notify(queue: .main) {
            self.updateProductsToShow()
        }
    }
    
    func getProductList(dispatchGroup: DispatchGroup) {
        self.productListRepository.getProductList { [weak self] products in
            guard let self = self else {
                dispatchGroup.leave()
                return
            }
            self.products = products
            dispatchGroup.leave()
        }
    }
    
    func getCategoryList(dispatchGroup: DispatchGroup) {
        productListRepository.getCategoryList(completion: {
            [weak self] categories in
            guard let self = self else {
                dispatchGroup.leave()
                return
            }
            self.categories = [Int:String]()
            for category in categories ?? [] {
                self.categories?[category.id] = category.name
            }
            dispatchGroup.leave()
        })
    }
    
    func updateProductsToShow() {
        for i in 0 ..< (self.products?.count ?? 0){
            if let id = self.products?[i].category_id {
                self.products?[i].categoryName = self.categories?[id]
            }
        }
        self.productsToShow.value = self.sortedProducts(self.products ?? [])
    }
    
    func filterByCategory(_ id: Int?) {
        if id != nil {
            self.productsToShow.value = products?
                .filter({ (product) -> Bool in
                product.category_id == id
            })
                .sorted(by: sortMethod)
        } else {
            self.productsToShow.value = sortedProducts(products ?? [])
        }
    }
    
    func categoriesAsArray() -> [(Int, String)]{
        var array = [(Int, String)]()
        for (key, value) in categories ?? [Int:String]() {
            array.append((key, value))
        }
        return array.sorted { (t1, t2) -> Bool in
            t1.0 < t2.0
        }
    }
}
