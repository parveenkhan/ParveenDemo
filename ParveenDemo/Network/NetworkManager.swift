//
//  NetworkManager.swift
//  ParveenDemo
//
//  Created by ParveenKhan on 03/12/24.
//
import Foundation

protocol NetworkManagerProtocol {
    func fetchCryptoList(completion: @escaping (Result<[Crypto], NetworkServiceError>) -> Void)
}

enum NetworkServiceError: Error, LocalizedError {
    case badUrl
    case requestError(Error)
    case decodingError(Error)
    case invalidResponse
    case statusNotOK(Int)
    case noData
    
    var errorDescription: String? {
        switch self {
        case .badUrl:
            return "Invalid Url."
        case .requestError(let error):
            return "Request failed with error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .invalidResponse:
            return "The response from the server is invalid."
        case .statusNotOK(let statusCode):
            return "Request failed with status code: \(statusCode)"
        case .noData:
            return "No data was returned by the server."
        }
    }
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    private init() {}

    func fetchCryptoList(completion: @escaping (Result<[Crypto], NetworkServiceError>) -> Void) {
        guard let url = URL(string: ApiConstants.coinListUrl) else {
            completion(.failure(.badUrl))
            return
        }
 
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle networking errors
            if let error = error {
                completion(.failure(.requestError(error)))
                return
            }
            
            // Validate HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.statusNotOK(httpResponse.statusCode)))
                return
            }
            
            // Validate data
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // Decode JSON
            do {
                let cryptoList = try JSONDecoder().decode([Crypto].self, from: data)
                completion(.success(cryptoList))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
}
