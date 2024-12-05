//
//  NetworkManager.swift
//  ParveenDemo
//
//  Created by ParveenKhan on 03/12/24.
//
import Foundation

protocol NetworkManagerProtocol {
    func fetchCryptoList(completion: @escaping (Result<[Crypto], Error>) -> Void)
}

//Note we can improve the network class
enum NetworkserviceError: Error {
    case badUrl, requestError, decodingError, statusNotOK
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()

    func fetchCryptoList(completion: @escaping (Result<[Crypto], Error>) -> Void) {
        guard let url = URL(string: ApiConstants.coinListUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let cryptoList = try JSONDecoder().decode([Crypto].self, from: data)
                completion(.success(cryptoList))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
