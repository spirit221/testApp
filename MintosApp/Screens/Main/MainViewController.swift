//
//  MainViewController.swift
//  MintosApp
//
//  Created by Sergey Gusev on 18.08.2023.
//

import UIKit

protocol MainView: AnyObject {
    func update()
    func showError(message: String)
}

final class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPresenter()
        presenter.fetchTransfer()
    }
    
    private func setupPresenter() {
        presenter = MainPresenter(view: self,
                                  bankAccountService: ServiceLocator.shared.getBankAccountService())
    }
    
    private func setupUI() {
        setupTableView()
        registerCellsAndHeaders()
    }
    
    private func setupTableView() {
        tableView.sectionHeaderTopPadding = 0
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0);
    }
    
    private func registerCellsAndHeaders() {
        let cellIdentifiers = [
            Strings.Id.transferTitleCell,
            Strings.Id.transferItemCell,
            Strings.Id.transferBankNameCell,
            Strings.Id.transferSpaceCell
        ]
        cellIdentifiers.forEach {
            tableView.register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0)
        }
        
        tableView.register(
            UINib(nibName: Strings.Id.transferHeaderView, bundle: nil),
            forHeaderFooterViewReuseIdentifier: Strings.Id.transferHeaderView
        )
    }
    
    private func showAlert(title: String, message: String, buttonTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - MainView
extension MainViewController: MainView {
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        showAlert(title: Strings.Localization.error,
                  message: message,
                  buttonTitle: Strings.Localization.ok)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.mainModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if case .space = presenter.mainModels[indexPath.section].cells[indexPath.row] {
            return 16
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.mainModels[section].isCollapsed ? numberOfRows(forSection: section) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.mainModels[indexPath.section].cells[indexPath.row]
        
        switch model {
        case let .title(model):
            let cell = tableView.dequeueReusableCell(withIdentifier: Strings.Id.transferTitleCell, for: indexPath) as? TransferTitleCell
            cell?.setUp(model)
            return cell!
        case let .info(model):
            let cell = tableView.dequeueReusableCell(withIdentifier: Strings.Id.transferItemCell, for: indexPath) as? TransferItemCell
            cell?.setUp(model)
            cell?.delegate = self
            return cell!
        case let .bankName(value):
            let cell = tableView.dequeueReusableCell(withIdentifier: Strings.Id.transferBankNameCell, for: indexPath) as? TransferBankNameCell
            cell?.setUp(bankName: value)
            return cell!
        case .space:
            let cell = tableView.dequeueReusableCell(withIdentifier: Strings.Id.transferSpaceCell, for: indexPath) as? TransferSpaceCell
            return cell!
        }
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Strings.Id.transferHeaderView) as! TransferHeaderView
        headerView.delegate = self
        headerView.setUp(section: section,
                         title: Strings.Localization.currency,
                         subtitle: presenter.mainModels[section].currencyCode)
        return headerView
    }
    
    func numberOfRows(forSection section: Int) -> Int {
        return presenter.mainModels[section].cells.count
    }
}

// MARK: - TransferHeaderViewProtocol
extension MainViewController: TransferHeaderViewProtocol {
    func headerButtonDidPress(section: Int) {
        presenter.mainModels[section].isCollapsed.toggle()
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}

// MARK: - TransferItemCellProtocol
extension MainViewController: TransferItemCellProtocol {
    func copyValue(_ value: String) {
        UIPasteboard.general.string = value
        showAlert(title: Strings.Localization.copied,
                  message: Strings.Localization.valueCopied,
                  buttonTitle: Strings.Localization.ok)
    }
}
