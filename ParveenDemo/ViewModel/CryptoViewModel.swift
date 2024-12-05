//
//  CryptoViewModel.swift
//  ParveenDemo
//
//  Created by ParveenKhan on 03/12/24.
//

import Foundation


protocol CryptoListViewModelProtocol {
    
    func fetchCryptos()
    func filter(active: Bool?, type: String?, isNew: Bool?)
    func resetFiltersAndSearch()
    func search(text: String)
}




class CryptoViewModel: CryptoListViewModelProtocol  {
    private var cryptoList: [Crypto] = []
    var filteredList: [Crypto] = []
    var onUpdate: (() -> Void)?

    
    /// to fetch the crpto list from network
    func fetchCryptos() {
        NetworkManager.shared.fetchCryptoList { [weak self] result in
            switch result {
            case .success(let cryptos):
                self?.cryptoList = cryptos
                self?.filteredList = cryptos
                self?.onUpdate?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    /// to filter the crypto according to selected actions
    /// - Parameters:
    ///   - active: A bool value which shows filter is for  active or inActive crpto
    ///   - type: A string value which shows filtered list should show coin type or token type
    ///   - isNew: A bool value shows the filtered list should show only new coins
    func filter(active: Bool?, type: String?, isNew: Bool?) {
        filteredList = cryptoList.filter { crypto in
            let isActiveMatch = active == nil || crypto.isActive == active
            let isTypeMatch = type == nil || crypto.type.lowercased() == type?.lowercased()
            let isNewMatch = isNew == nil || crypto.isNew == isNew
            return isActiveMatch && isTypeMatch && isNewMatch
        }
        onUpdate?()
    }
    
    
    /// to reset the all filters and search
    func resetFiltersAndSearch() {
            filteredList = cryptoList
            onUpdate?()
        }

    
    /// to search the crypto by coin name or coin symbol
    /// - Parameter text: A search text
    func search(text: String) {
        
        guard !text.isEmpty else {
            resetFiltersAndSearch()
            return
        }
        
        filteredList = cryptoList.filter {
            $0.name.lowercased().contains(text.lowercased()) ||
            $0.symbol.lowercased().contains(text.lowercased())
        }
        onUpdate?()
    }
}
