//
//  BottomFilterView.swift
//  ParveenDemo
//
//  Created by ParveenKhan on 03/12/24.
//

import UIKit




/// Bottom filter view to filter the crypto coins e.g. Active coins, inActive coins, only Token etc
class BottomFilterView: UIView {
    let activeCoinsButton = UIButton(type: .roundedRect)
    let inactiveCoinsButton = UIButton(type: .system)
    let onlyTokensButton = UIButton(type: .system)
    let onlyCoinsButton = UIButton(type: .system)
    let newCoinsButton = UIButton(type: .system)
    
    var buttons: [UIButton] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        
        buttons = [activeCoinsButton, inactiveCoinsButton, onlyTokensButton, onlyCoinsButton, newCoinsButton]
        let actionTitles = CryptoConstants.actionTitles
        
        var configuration = UIButton.Configuration.plain()
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        
        // Set padding around the text
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
            
        
        for (i, button) in buttons.enumerated() {
            button.setTitle(actionTitles[i], for: .normal)
            button.backgroundColor = .white
            button.layer.masksToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(toggleSelection(_:)), for: .touchUpInside)
            button.configuration = configuration
            button.layer.cornerRadius = button.frame.size.height / 2
            button.tag = i

        }
        
        // Layout buttons in a horizontal stack
        let stackView1 = UIStackView(arrangedSubviews: [activeCoinsButton, inactiveCoinsButton, onlyTokensButton])
        stackView1.axis = .horizontal
        stackView1.distribution = .fillProportionally
        stackView1.alignment = .center
        stackView1.spacing = 5
        addSubview(stackView1)
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        
        
        let stackView2 = UIStackView(arrangedSubviews: [onlyCoinsButton, newCoinsButton])
        stackView2.axis = .horizontal
        stackView2.distribution = .fillEqually
        stackView2.alignment = .center
        stackView2.spacing = 5
        addSubview(stackView2)
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [stackView1, stackView2])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        

        // Constraints for stack view
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        stackView.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for button in buttons {
            button.layer.cornerRadius = button.frame.height / 2
            button.layer.masksToBounds = true
        }
    }
    
    
    /// to remove all filters
    func removeAllFilters() {
        for button in buttons {
            button.isSelected = false
            button.configuration?.image = nil
            button.backgroundColor = .white
        }
    }
    
    /// to update the UI of action button according to the slection
    /// - Parameter sender: An action button
    /// User can select single and multiple filter
    ///   case1 - user can select either Active or inActive
    ///   case 2 - user can select either only token or only coin
    ///
    ///       //tag 0 Active Coins
    //tag 1 Inactive coins
    //tage2 only token
    //tag 3 only coins
    //tag 4 New coins
    
   
    @objc func toggleSelection(_ sender: UIButton) {
        
        switch(sender.tag) {
        //Active Coins
        case 0:
            sender.isSelected.toggle()
            inactiveCoinsButton.isSelected = false
            inactiveCoinsButton.configuration?.image = nil
            inactiveCoinsButton.backgroundColor = .white
        //Inactive coins
        case 1:
            sender.isSelected.toggle()
            activeCoinsButton.isSelected = false
            activeCoinsButton.configuration?.image = nil
            activeCoinsButton.backgroundColor = .white
        //only token
        case 2:
            sender.isSelected.toggle()
            onlyCoinsButton.isSelected = false
            onlyCoinsButton.configuration?.image = nil
            onlyCoinsButton.backgroundColor = .white
        //Only coins
        case 3:
            sender.isSelected.toggle()
            onlyTokensButton.isSelected = false
            onlyTokensButton.configuration?.image = nil
            onlyTokensButton.backgroundColor = .white
       //4 - New coins
        default:
            sender.isSelected.toggle()
        }
        
        if sender.isSelected {
             sender.configuration?.image = UIImage(systemName: "checkmark")
             sender.backgroundColor = UIColor(red: 209.0/255.0, green: 209.0/255.0, blue: 209.0/255.0, alpha: 1.0)

        } else {
            sender.configuration?.image = nil
            sender.backgroundColor = .white

        }
        
        
    }
    
}
