//
//  FiltersViewController.swift
//  TestLeboncoin
//
//  Created by Omar REDA on 02/05/2021.
//

import UIKit

protocol FiltersDelegate {
    func didSelectCategory(_ id: Int?)
}

class FiltersViewController: UITableViewController {
    
    var delegate: FiltersDelegate?
    var categories = [(Int, String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < categories.count {
            delegate?.didSelectCategory(categories[indexPath.row].0)
        } else {
            delegate?.didSelectCategory(nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if indexPath.row < categories.count {
            let text = categories[indexPath.row].1
            cell.textLabel?.text = text
        } else {
            cell.textLabel?.text = "Tout"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count + 1
    }
}
