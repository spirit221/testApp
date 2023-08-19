//
//  BankAccountResponse.swift
//  MintosApp
//
//  Created by Sergey Gusev on 18.08.2023.
//

struct BankAccountResponse: Codable {
    let response: ItemResponse
}

struct ItemResponse: Codable {
    let paymentDetails: String
    let items: [BankAccount]
}

struct BankAccount: Codable {
    let bank: String
    let swift: String
    let currency: String
    let beneficiaryName: String
    let beneficiaryBankAddress: String
    let iban: String
}

