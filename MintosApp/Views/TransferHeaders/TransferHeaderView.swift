//
//  TransferHeaderView.swift
//  MintosApp
//
//  Created by Sergey Gusev on 18.08.2023.
//

import UIKit

protocol TransferHeaderViewProtocol: AnyObject {
    func headerButtonDidPress(section: Int)
}

final class TransferHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    private var section: Int?
    public weak var delegate: TransferHeaderViewProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTapGesture()
        setupImageView()
        setupBackgroundConfiguration()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    private func setupImageView() {
        imageView.layer.cornerRadius = 20
    }
    
    private func setupBackgroundConfiguration() {
        var backgroundConfiguration = UIBackgroundConfiguration.listPlainHeaderFooter()
        backgroundConfiguration.backgroundColor = .white
        self.backgroundConfiguration = backgroundConfiguration
    }
    
    @objc private func headerTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let section = section else { return }
        delegate?.headerButtonDidPress(section: section)
    }
    
    public func setUp(section: Int, title: String, subtitle: String) {
        self.section = section
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
