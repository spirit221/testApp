//
//  TransferBankNameCellTableViewCell.swift
//  MintosApp
//
//  Created by Sergey Gusev on 18.08.2023.
//

import UIKit

final class TransferBankNameCell: UITableViewCell {
    @IBOutlet private weak var bankNameLabel: UILabel!
    @IBOutlet private weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundCorners()
    }
    
    private func roundCorners() {
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 10
        cardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    public func setUp(bankName: String) {
        bankNameLabel.text = bankName
    }
    
}
