//
//  BottomFilterView.swift
//  ParveenDemo
//
//  Created by ParveenKhan on 03/12/24.
//

import UIKit

//
class BottomFilterView: UIView {
    
    private let mainStackView = UIStackView()
    private let row1StackView = UIStackView()
    private let row2StackView = UIStackView()
    
    // Filter Buttons
    lazy var activeCoinsButton: UIButton = createFilterButton(title: CryptoConstants.actionTitles[0], tag: 0)
    lazy var inactiveCoinsButton: UIButton = createFilterButton(title: CryptoConstants.actionTitles[1], tag: 1)
    lazy var onlyTokensButton: UIButton = createFilterButton(title: CryptoConstants.actionTitles[2], tag: 2)
    lazy var onlyCoinsButton: UIButton = createFilterButton(title: CryptoConstants.actionTitles[3], tag: 3)
    lazy var newCoinsButton: UIButton = createFilterButton(title: CryptoConstants.actionTitles[4], tag: 4)
    
    var buttons: [UIButton] = []
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        buttons = [activeCoinsButton, inactiveCoinsButton, onlyTokensButton, onlyCoinsButton, newCoinsButton]
        
        // Configure Main StackView
        addSubview(mainStackView)
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure Row StackViews
        configureRowStackView(row1StackView)
        configureRowStackView(row2StackView)
        
        // Add Buttons to Rows
        row1StackView.addArrangedSubview(activeCoinsButton)
        row1StackView.addArrangedSubview(inactiveCoinsButton)
        row1StackView.addArrangedSubview(onlyCoinsButton)
        
        row2StackView.addArrangedSubview(newCoinsButton)
        row2StackView.addArrangedSubview(onlyTokensButton)
        
        // Add Rows to Main StackView
        mainStackView.addArrangedSubview(row1StackView)
        mainStackView.addArrangedSubview(row2StackView)
        
        // Auto Layout
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func configureRowStackView(_ stackView: UIStackView) {
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createFilterButton(title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.black, for: .normal) // Text color is black in all states
        button.backgroundColor = .white // Background is white
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true // Prevent overflow of content
        button.tag = tag
        button.setImage(nil, for: .normal) // No image initially
        button.contentHorizontalAlignment = .center
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        //  button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(toggleSelection(_:)), for: .touchUpInside)
        button.isSelected = false // Default unselected state
        
        // Set consistent background for all states
        button.setBackgroundImage(UIImage(ciImage: .white), for: .normal)
        button.setBackgroundImage(UIImage(ciImage: .white), for: .highlighted)
        button.setBackgroundImage(UIImage(ciImage: .white), for: .selected)
        
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true // Consistent height
        updateButtonAppearance(button)
        return button
    }
    
    private func updateButtonAppearance(_ button: UIButton) {
        if button.isSelected {
            button.setImage(UIImage(systemName: "checkmark"), for: .normal) // Add checkmark image
            button.imageView?.tintColor = .black // Image color is black
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10) // Spacing between text and image
        } else {
            button.setImage(nil, for: .normal) // Remove image when unselected
        }
        button.setTitleColor(.black, for: .normal) // Text color remains black
        button.backgroundColor = .white // Background remains white
    }
    
    // Action Handlers
    @objc private func filterButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle() // Toggle the selection state
        updateButtonAppearance(sender)
        print("\(sender.titleLabel?.text ?? "") Filter \(sender.isSelected ? "Selected" : "Unselected")")
    }
    
    /// to remove all filters
    func removeAllFilters() {
        buttons.forEach {
            $0.isSelected = false
            updateButtonAppearance($0)
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
        // sender.isSelected.toggle() // Toggle the selection state
        // updateButtonAppearance(sender)
        switch(sender.tag) {
            //Active Coins
        case 0:
            sender.isSelected.toggle()
            updateButtonAppearance(sender)
            inactiveCoinsButton.isSelected = false
            updateButtonAppearance(inactiveCoinsButton)
            // inactiveCoinsButton.configuration?.image = nil
            //Inactive coins
        case 1:
            sender.isSelected.toggle()
            updateButtonAppearance(sender)
            activeCoinsButton.isSelected = false
            updateButtonAppearance(activeCoinsButton)
            
        case 2:
            sender.isSelected.toggle()
            updateButtonAppearance(sender)
            onlyCoinsButton.isSelected = false
            updateButtonAppearance(onlyCoinsButton)
            
            //Only coins
        case 3:
            sender.isSelected.toggle()
            updateButtonAppearance(sender)
            
            onlyTokensButton.isSelected = false
            updateButtonAppearance(onlyTokensButton)
            
            //4 - New coins
        default:
            sender.isSelected.toggle()
            updateButtonAppearance(sender)
        }
        
    }
    
}
