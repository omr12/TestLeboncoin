//
//  Network.swift
//  TestLeboncoin
//
//  Created by Omar REDA on 02/05/2021.
//

import Foundation

enum Endpoints: String {
    case category = "leboncoin/paperclip/master/categories.json"
    case product = "leboncoin/paperclip/master/listing.json"
}

class Network {
    
    private let endpoint = "https://raw.githubusercontent.com"
    
    func getItem<T: Decodable>(_ path: String, parameters: [String: Any]?, completion: @escaping (T?) -> Void) {
        let absolutePath = "\(endpoint)/\(path)"
        guard let url = URL(string: absolutePath) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let _data = data, let _response = response as? HTTPURLResponse, _response.statusCode / 100 == 2 {
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: _data)
                    completion(responseObject)
                } catch {
                    print(error)
                }
            } else {
                completion(nil)
            }
        }).resume()
    }
    
    func loadImageFromUrl(url urlString: String, completion: @escaping (Data) -> Void) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (responseData, responseUrl, error) -> Void in
                if let data = responseData {
                    completion(data)
                }
            }
            task.resume()
        }
    }
}
