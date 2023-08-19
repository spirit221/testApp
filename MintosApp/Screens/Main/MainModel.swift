//
//  MainModel.swift
//  MintosApp
//
//  Created by Sergey Gusev on 18.08.2023.
//

import UIKit

struct MainModel {
    let currencyCode: String
    let paymentDetails: String
    let cells: [MainCell]
    
    var isCollapsed: Bool
}

enum MainCell {
    case title(MainCellTitleModel)
    case info(MainCellInfoModel)
    case bankName(value: String)
    case space
}

struct MainCellTitleModel {
    let title: String
    let subtitle: String
}

struct MainCellInfoModel {
    let title: String
    let value: String
    let roundedEdges: RoundedEdges
}

enum RoundedEdges {
    case top
    case bottom
    case all
    case none
}

extension MainModel {
    static func generate(currencyCode: String, paymentDetails: String, bankAccounts: [BankAccount]) -> MainModel {
        let topCells: [MainCell] = [
            .title(MainCellTitleModel(title: Strings.Localization.bankTransferTitle,
                                      subtitle: Strings.Localization.bankTransferSubtitle)),
            .info(MainCellInfoModel(title: Strings.Localization.paymentDetails,
                                    value: paymentDetails,
                                    roundedEdges: .all)),
            .space
        ]
        let bankCells: [MainCell] = bankAccounts.flatMap { account in
            return [
                .bankName(value: account.bank),
                .info(MainCellInfoModel(title: Strings.Localization.iban,
                                        value: account.iban,
                                        roundedEdges: .none)),
                .info(MainCellInfoModel(title: Strings.Localization.swift,
                                        value: account.swift,
                                        roundedEdges: .none)),
                .info(MainCellInfoModel(title: Strings.Localization.beneficiaryName,
                                        value: account.beneficiaryName,
                                        roundedEdges: .none)),
                .info(MainCellInfoModel(title: Strings.Localization.beneficiaryBankAddress,
                                        value: account.beneficiaryBankAddress,
                                        roundedEdges: .bottom)),
                .space
            ]
        }
        let cells = topCells + bankCells
        
        return MainModel(currencyCode: currencyCode, paymentDetails: paymentDetails, cells: cells, isCollapsed: true)
    }
}
