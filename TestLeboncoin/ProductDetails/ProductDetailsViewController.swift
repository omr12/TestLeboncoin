//
//  ProductDetailsViewController.swift
//  TestLeboncoin
//
//  Created by Omar REDA on 29/04/2021.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    let viewModel = ProductDetailsViewModel()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_close"), for: .normal)
        button.addTarget(self, action: #selector(ProductDetailsViewController.close), for: .touchUpInside)
        return button
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "placeholder")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let urgentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .orange
        label.textAlignment = .center
        label.text = "URGENT"
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraint()
        updateUI()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
        self.view.addSubview(closeButton)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(categoryLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(urgentLabel)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            self.closeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
            self.closeButton.widthAnchor.constraint(equalToConstant: 30),
            self.closeButton.heightAnchor.constraint(equalToConstant: 30),
            
            self.scrollView.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: 10),
            self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            self.contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            self.imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            self.imageView.heightAnchor.constraint(equalToConstant: 200),
            
            self.urgentLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            self.urgentLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),

            self.categoryLabel.topAnchor.constraint(equalTo: self.urgentLabel.bottomAnchor, constant: 20),
            self.categoryLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 3),
            self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            
            self.priceLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.priceLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            self.priceLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 10),
            
            self.dateLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 10),
            self.dateLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            self.dateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func updateUI() {
        self.titleLabel.text = viewModel.product?.title
        self.dateLabel.text = viewModel.product?.dateText
        self.categoryLabel.text = viewModel.product?.categoryName?.uppercased()
        self.priceLabel.text = viewModel.product?.priceText
        self.descriptionLabel.text = viewModel.product?.description
        self.urgentLabel.text = (viewModel.product?.is_urgent ?? false) ? "URGENT" : nil
        if let data = viewModel.productImageData.value {
            self.imageView.image = UIImage(data: data) ?? UIImage(named: "placeholder")
        } else {
            viewModel.productImageData.bind { (imageData) in
                if let data = imageData, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.self.imageView.image = image
                    }
                }
            }
        }
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
