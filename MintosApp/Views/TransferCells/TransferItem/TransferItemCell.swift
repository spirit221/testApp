//
//  TransferItemCell.swift
//  MintosApp
//
//  Created by Sergey Gusev on 18.08.2023.
//

import UIKit

protocol TransferItemCellProtocol: AnyObject {
    func copyValue(_ value: String)
}

final class TransferItemCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var copyButton: UIButton!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var separatorView: UIView!
    private var value: String = ""
    
    public weak var delegate: TransferItemCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.clipsToBounds = true
    }
    
    private func setUpCardView(edges: RoundedEdges) {
        switch edges {
        case .top:
            cardView.backgroundColor = .white
            cardView.layer.cornerRadius = 10
            cardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            separatorView.isHidden = false
        case .bottom:
            cardView.backgroundColor = .white
            cardView.layer.cornerRadius = 10
            cardView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            
            separatorView.isHidden = true
        case .all:
            cardView.backgroundColor = Colors.paymentDetailColor
            cardView.layer.cornerRadius = 10
            cardView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            separatorView.isHidden = true
        case .none:
            cardView.backgroundColor = .white
            cardView.layer.cornerRadius = 0
            
            separatorView.isHidden = false
        }
        
    }

    @IBAction private func buttonDidPress(_ sender: UIButton) {
        delegate?.copyValue(value)
    }
    
    public func setUp(_ model: MainCellInfoModel) {
        titleLabel.text = model.title
        valueLabel.text = model.value
        setUpCardView(edges: model.roundedEdges)
        self.value = model.value
    }
    
}
