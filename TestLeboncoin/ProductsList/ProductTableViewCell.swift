//
//  ProductTableViewCell.swift
//  TestLeboncoin
//
//  Created by Omar REDA on 28/04/2021.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ProductCell"
    let network = Network()
    
    let productImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        return label
    }()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupConstraints()

    }
    
    func setupViews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(categoryLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            priceLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            categoryLabel.leftAnchor.constraint(equalTo: priceLabel.leftAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func updateUI(product: Product) {
        self.selectionStyle = .none
        self.productImageView.image = UIImage(named: "placeholder")
        self.titleLabel.text = product.title
        self.priceLabel.text = String(format: "%.2f €", product.price ?? 0)
        self.categoryLabel.text = product.categoryName
        self.titleLabel.textColor = (product.is_urgent ?? false) ? .orange : .black
        if let imageUrl = product.images_url?.small {
            network.loadImageFromUrl(url: imageUrl) { (data) in
                DispatchQueue.main.async {
                    self.productImageView.image = UIImage(data: data) ?? UIImage(named: "placeholder")
                }
            }
        }
    }
}
