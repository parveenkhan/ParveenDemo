//
//  ParveenDemoTests.swift
//  ParveenDemoTests
//
//  Created by ParveenKhan on 03/12/24.
//

import Testing
import XCTest
@testable import ParveenDemo

class ParveenDemoTests: XCTestCase {

    var viewModel: CryptoViewModel!
    var mockCrypto: [Crypto]!
    
    override func setUp() {
            super.setUp()
            viewModel = CryptoViewModel()
            mockCrypto = [
                Crypto(name: "Bitcoin", symbol: "BTC", type: "coin", isActive: true, isNew: false),
                Crypto(name: "Ethereum", symbol: "ETH", type: "coin", isActive: true, isNew: true),
                Crypto(name: "Tether", symbol: "USDT", type: "token", isActive: false, isNew: false)
            ]
            viewModel.cryptoList = mockCrypto
            viewModel.filteredList = mockCrypto
        }

        override func tearDown() {
            viewModel = nil
            mockCrypto = nil
            super.tearDown()
        }

        func testFilterActive() {
            viewModel.filter(active: true, type: nil, isNew: nil)
            XCTAssertEqual(viewModel.filteredList.count, 2)
        }

        func testFilterInactive() {
            viewModel.filter(active: false, type: nil, isNew: nil)
            XCTAssertEqual(viewModel.filteredList.count, 1)
        }

        func testFilterByType() {
            viewModel.filter(active: nil, type: "token", isNew: nil)
            XCTAssertEqual(viewModel.filteredList.count, 1)
        }

        func testFilterByIsNew() {
            viewModel.filter(active: nil, type: nil, isNew: true)
            XCTAssertEqual(viewModel.filteredList.count, 1)
        }

        func testSearchByName() {
            viewModel.search(text: "Bitcoin")
            XCTAssertEqual(viewModel.filteredList.count, 1)
        }

        func testResetFiltersAndSearch() {
            viewModel.filter(active: true, type: "coin", isNew: true)
            viewModel.resetFiltersAndSearch()
            XCTAssertEqual(viewModel.filteredList.count, 3)
        }
    
}
