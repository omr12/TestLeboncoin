//
//  ViewController.swift
//  TestLeboncoin
//
//  Created by Omar REDA on 28/04/2021.
//

import UIKit

class ProductListViewController: UIViewController {
    
    private var viewModel = ProductListViewModel()
    
    private var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var filterButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_filter"), for: .normal)
        button.tintColor = .orange
        button.setTitle(nil, for: .normal)
        button.addTarget(self, action: #selector(ProductListViewController.showFilters), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(filterButton)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            filterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            filterButton.heightAnchor.constraint(equalToConstant: 20),
            filterButton.widthAnchor.constraint(equalToConstant: 20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: filterButton.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        self.tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setupBinding() {
        viewModel.productsToShow.bind { (products) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func showFilters() {
        let filtersVC = FiltersViewController()
        filtersVC.categories = viewModel.categoriesAsArray()
        filtersVC.delegate = self
        self.present(filtersVC, animated: true, completion: nil)
    }
}

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductDetailsViewController()
        vc.viewModel.product = viewModel.productsToShow.value?[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsToShow.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier, for: indexPath) as! ProductTableViewCell
        if let product = viewModel.productsToShow.value?[indexPath.row] {
            cell.updateUI(product: product)
        }
        return cell
    }
}

extension ProductListViewController: FiltersDelegate {
    func didSelectCategory(_ id: Int?) {
        viewModel.filterByCategory(id)
    }
}
