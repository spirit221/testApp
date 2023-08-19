//
//  BankAccountService.swift
//  MintosApp
//
//  Created by Sergey Gusev on 18.08.2023.
//

import Foundation

enum BankAccountServiceError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return NSLocalizedString(Strings.Localization.invalidURLError,
                                     comment: Strings.Localization.commentError)
        case .networkError(_):
            return NSLocalizedString(Strings.Localization.networkError,
                                     comment: Strings.Localization.commentError)
        case .decodingError(_):
            return NSLocalizedString(Strings.Localization.decodingError,
                                     comment: Strings.Localization.commentError)
        }
    }
}

protocol BankAccountServiceProtocol {
    typealias CompletionHandler = (Result<BankAccountResponse, BankAccountServiceError>) -> Void
    func fetchBankAccountData(completion: @escaping CompletionHandler)
}


class BankAccountService: BankAccountServiceProtocol {
    
    func fetchBankAccountData(completion: @escaping CompletionHandler) {
        guard let url = URL(string: Strings.Url.baseUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(BankAccountResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        task.resume()
    }
}
