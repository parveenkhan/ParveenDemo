//
//  ViewController.swift
//  ParveenDemo
//
//  Created by ParveenKhan on 03/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel = CryptoViewModel()
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private let bottomFilterView = BottomFilterView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        view.backgroundColor = AppColors.primary
        
        setupUI()
        bindViewModel()
        viewModel.fetchCryptos()
        setupFilterActions()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent // Change to .darkContent for dark text
        }

    /// to setup the screen UI
    private func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(bottomFilterView)
       
        searchBar.placeholder = "COIN"
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CryptoCell.self, forCellReuseIdentifier: "CryptoCell")
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        bottomFilterView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomFilterView.backgroundColor = .gray
       // searchBar.backgroundColor = UIColor(red: 255.0/89.0, green: 255.0/13.0, blue: 255.0/228.0, alpha: 1.0)
        
        let textField = searchBar.searchTextField
        textField.delegate = self
        textField.backgroundColor = AppColors.primary
        searchBar.barTintColor = AppColors.primary
        textField.borderStyle = .none
        searchBar.tintColor = .white
        searchBar.setIconColor(.white)
        searchBar.setPlaceholderColor(.white)
        
        searchBar.searchTextField.backgroundColor = AppColors.primary
        searchBar.searchTextField.textColor = .white
        searchBar.tintColor = .white
    
        customSearchBarUI()
        
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomFilterView.topAnchor),
            
            bottomFilterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomFilterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomFilterView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
      
    private func customSearchBarUI() {
        // Ensure cancel button is visible
        searchBar.showsCancelButton = true
        
        // Customize cancel button color
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitleColor(.gray, for: .normal)
        }
        
        // Access the search text field for further customizations
        let textField: UITextField = searchBar.searchTextField
        // Customize search text and placeholder
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search here",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textField.clearButtonMode = .never
        
        // Optionally customize search icon
        if let searchIcon = textField.leftView as? UIImageView {
            searchIcon.tintColor = .white // Set desired color
        }
    }
    
    /// to add target on button action
    private func setupFilterActions() {
            bottomFilterView.activeCoinsButton.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
           bottomFilterView.inactiveCoinsButton.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
           bottomFilterView.onlyTokensButton.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
           bottomFilterView.onlyCoinsButton.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
           bottomFilterView.newCoinsButton.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
    }
    
    
    @objc private func filterAction() {
        searchBar.text = ""
        let type = bottomFilterView.onlyCoinsButton.isSelected ? CryptoType.coin.rawValue :  (bottomFilterView.onlyTokensButton.isSelected ?  CryptoType.token.rawValue : nil)
        
        viewModel.filter(active: bottomFilterView.activeCoinsButton.isSelected, type: type, isNew: bottomFilterView.newCoinsButton.isSelected)
    }

    
    /// to remove all filters (UI and data) and search
    private func removeAllFilters() {
        bottomFilterView.removeAllFilters()
        viewModel.resetFiltersAndSearch()
    }
    
   
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as? CryptoCell else {
            return UITableViewCell()
        }
        let crypto = viewModel.filteredList[indexPath.row]
        cell.configure(with: crypto)
        return cell
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(text: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.resetFiltersAndSearch()
    }
    
  
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() 
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        removeAllFilters()
    }
}
