//
//  CryptoCellTableViewCell.swift
//  ParveenDemo
//
//  Created by ParveenKhan on 03/12/24.
//

import UIKit

class CryptoCell: UITableViewCell {
    
    let name = UILabel()
    let symbol = UILabel()
    let statusImageView = UIImageView()
    let newCoin = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // Add labels and image view to the content view
        contentView.addSubview(name)
        contentView.addSubview(symbol)
       // contentView.addSubview(typeLabel)
        contentView.addSubview(statusImageView)
        contentView.addSubview(newCoin)

        name.translatesAutoresizingMaskIntoConstraints = false
        symbol.translatesAutoresizingMaskIntoConstraints = false
       // typeLabel.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        newCoin.translatesAutoresizingMaskIntoConstraints = false
        

        // Layout constraints
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            symbol.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            symbol.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            symbol.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            statusImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            statusImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusImageView.widthAnchor.constraint(equalToConstant: 30),
            statusImageView.heightAnchor.constraint(equalToConstant: 30),
            
            newCoin.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1),
            newCoin.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            newCoin.widthAnchor.constraint(equalToConstant: 30),
            newCoin.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configure(with crypto: Crypto) {
        self.backgroundColor = crypto.isActive ? .white : UIColor(white: 0.9, alpha: 1.0)
        self.isUserInteractionEnabled = crypto.isActive
        name.text = crypto.name
        symbol.text = crypto.symbol
      //  typeLabel.text = crypto.type
        statusImageView.image = getCryptoImage(crypto: crypto)
        statusImageView.tintColor = crypto.isActive ? .green : .red
        newCoin.image = crypto.isNew ? CryptoImage.newcoin : nil
    }
    
    func getCryptoImage(crypto: Crypto) -> UIImage? {
        
        return crypto.isActive ? (crypto.type == CryptoType.coin.rawValue ? CryptoImage.coin  : CryptoImage.token) : CryptoImage.inactive
    }
    
}
