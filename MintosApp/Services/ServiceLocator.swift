//
//  ServiceLocator.swift
//  MintosApp
//
//  Created by Sergey Gusev on 19.08.2023.
//

import Foundation

class ServiceLocator {
    static let shared = ServiceLocator()
    
    private init() {}
    
    private lazy var bankAccountService: BankAccountServiceProtocol = BankAccountService()
    
    func getBankAccountService() -> BankAccountServiceProtocol {
        return bankAccountService
    }
}
