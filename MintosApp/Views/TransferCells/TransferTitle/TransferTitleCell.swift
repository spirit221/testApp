//
//  TransferTitleCell.swift
//  MintosApp
//
//  Created by Sergey Gusev on 18.08.2023.
//

import UIKit

final class TransferTitleCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    public func setUp(_ model: MainCellTitleModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
}
