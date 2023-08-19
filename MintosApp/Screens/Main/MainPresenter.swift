//
//  MainPresenter.swift
//  MintosApp
//
//  Created by Sergey Gusev on 18.08.2023.
//

import UIKit

protocol MainPresenterProtocol {
    func fetchTransfer()
}

final class MainPresenter: MainPresenterProtocol {
    private weak var view: MainView?
    private let bankAccountService: BankAccountServiceProtocol
    
    public var mainModels: [MainModel] = []
    
    public init(view: MainView, bankAccountService: BankAccountServiceProtocol) {
        self.view = view
        self.bankAccountService = bankAccountService
    }
    
    public func fetchTransfer() {
        bankAccountService.fetchBankAccountData() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.mainModels = self.generateMainModel(from: data)
                self.view?.update()
            case let .failure(error):
                self.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    private func generateMainModel(from data: BankAccountResponse) -> [MainModel] {
        let groupedBankAccounts = Dictionary(grouping: data.response.items, by: { $0.currency })
        
        return groupedBankAccounts.map { currencyCode, bankAccounts in
            return MainModel.generate(currencyCode: currencyCode,
                                      paymentDetails: data.response.paymentDetails,
                                      bankAccounts: bankAccounts)
        }
    }
}
