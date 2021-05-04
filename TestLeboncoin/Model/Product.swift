//
//  Product.swift
//  TestLeboncoin
//
//  Created by Omar REDA on 28/04/2021.
//

import Foundation

struct Product: Decodable, Equatable {
    
    var category_id: Int?
    var title: String?
    var description: String?
    var price: Double?
    var creation_date: String?
    var is_urgent: Bool?
    var images_url: ImageURL?
    var categoryName: String?
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.category_id == rhs.category_id &&
        lhs.title == rhs.title &&
        lhs.description == rhs.description &&
        lhs.price == rhs.price &&
        lhs.creation_date == rhs.creation_date &&
        lhs.is_urgent == rhs.is_urgent &&
        lhs.images_url == rhs.images_url
    }
    
    var priceText: String {
        guard let price = price else { return "" }
        return String(format: "%.2f €", price)
    }
    
    var date: Date? {
        guard let date = creation_date else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        return formatter.date(from: date)
    }
    
    var dateText: String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        return formatter.string(from: date)
    }

}

struct ImageURL: Decodable, Equatable {
    var small: String?
    var thumb: String?
    
    static func == (lhs: ImageURL, rhs: ImageURL) -> Bool {
        lhs.small == rhs.small &&
        lhs.thumb == rhs.thumb
    }
}
