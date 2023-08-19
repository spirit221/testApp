//
//  Strings.swift
//  MintosApp
//
//  Created by Sergey Gusev on 19.08.2023.
//

import Foundation

struct Strings {
    
    struct Localization {
        static let currency = "Currency"
        static let bankTransferTitle = "Bank transfer"
        static let bankTransferSubtitle = "Transfer money from your bank account to your Mintos account"
        static let paymentDetails = "Add this information to payment details"
        static let iban = "Beneficiary bank account number / IBAN"
        static let swift = "Beneficiary bank SWIFT / BIC code"
        static let beneficiaryName = "Beneficiary name"
        static let beneficiaryBankAddress = "Beneficiary bank address"
        static let invalidURLError = "Beneficiary bank SWIFT / BIC code"
        static let networkError = "Network Error. Please check your internet connection and try again."
        static let decodingError = "Decoding Error. An error occurred while processing the data received from the server."
        static let commentError = "Bank Account Service Error"
        static let error = "Error"
        static let ok = "OK"
        static let copied = "Copied"
        static let valueCopied = "Value copied to clipboard"
    }

    struct Id {
        static let transferTitleCell = "TransferTitleCell"
        static let transferItemCell = "TransferItemCell"
        static let transferBankNameCell = "TransferBankNameCell"
        static let transferSpaceCell = "TransferSpaceCell"
        static let transferHeaderView = "TransferHeaderView"
        static let TransferHeaderView = "TransferHeaderView"
    }
    
    struct Url {
        static let baseUrl = "https://mintos-mobile.s3.eu-central-1.amazonaws.com/bank-accounts.json"
    }
}
