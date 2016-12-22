//
//  AccountDetailDataSource.swift
//  StatementList
//
//  Created by Shelton Han on 20/12/16.
//  Copyright © 2016 Shelton Han. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AccountDetailDataSource: NSObject {
    public let account: AccountDetail
    public let transactions: [Transaction]
    public let atms: [ATMDetial]
    public let transactionsByDates: [Date: [Transaction]]
    public var presentationDelegate: UIViewController?
    
    init(withDictionary dict:[String: AnyObject]) {
        // Account
        // Assume API will return a dictionary with account key
        self.account = AccountDetail(withDictionary: dict["account"] as! [String: AnyObject])
        
        // Transactions
        var aggregatedTransactions:[Transaction] = []
        if let dicts = dict["transactions"] as? [[String: AnyObject]] {
            aggregatedTransactions += dicts.map { (dict) -> Transaction in
                Transaction(withDictionary: dict)
            }
        }
        if let dicts = dict["pending"] as? [[String: AnyObject]] {
            aggregatedTransactions += dicts.map { (dict) -> Transaction in
                Transaction(withDictionary: dict, state:.Pending)
            }
        }
        self.transactions = aggregatedTransactions;
        
        var groupedTransactions: [Date: [Transaction]] = [:]
        aggregatedTransactions.forEach { transaction in
            if let sameDateTransactions = groupedTransactions[transaction.effectiveDate] {
                groupedTransactions[transaction.effectiveDate] = sameDateTransactions + [transaction]
            } else {
                groupedTransactions[transaction.effectiveDate] = [transaction]
            }
        }
        self.transactionsByDates = groupedTransactions
        
        // ATMs
        if let dicts = dict["atms"] as? [[String: AnyObject]] {
            self.atms = dicts.map { (dict) -> ATMDetial in
                ATMDetial(withDictionary: dict)
            }
        } else {
            self.atms = []
        }
        
    }
    
    public func setupTableView(_ tableView: UITableView, presentationDelegate:UIViewController) {
        // Setup tableView
        tableView.dataSource = self
        tableView.delegate = self
        
        let accountDetailHeader: AccountDetailHeaderCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.accountDetailHeader) as! AccountDetailHeaderCell
        accountDetailHeader.refreshView(accountDetail: self.account)
        tableView.tableHeaderView = accountDetailHeader
        
        self.presentationDelegate = presentationDelegate
    }
    
    public func predicatedSpending () -> NSNumber {
        let spending = self.spendingIn(days: 7) + self.spendingIn(days: 30) / 30 * 7
        return NSNumber(value: spending)
    }
    
    private func spendingIn(days: Int) -> Float {
        var spending: Float = 0.0
        let dateAdjustment = NSDateComponents()
        dateAdjustment.day = -days;
        if !transactionsByDates.isEmpty {
            let newDate = Calendar.current.date(byAdding: dateAdjustment as DateComponents, to: transactionsByDates.sortedKeys.first! as Date)
            self.transactions.forEach({ transaction in
                if (transaction.effectiveDate > newDate! && transaction.state == .Settled && transaction.amount.floatValue < 0) {
                    spending += transaction.amount.floatValue
                }
            })
        }
        return -spending
    }

}

struct CellIdentifiers {
    static let accountDetailHeader = "AccountDetailHeader"
    static let transactionCell = "TransactionCell"
    static let dateSectionHeader = "DateSectionHeader"
    static let emptyDataHeader = "EmptyDataHeader"
}

extension Dictionary where Key: Comparable {
    var sortedKeys: [Key] {
        get {
            return keys.sorted { $0 > $1 }
        }
    }
}

extension AccountDetailDataSource: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.transactionsByDates.keys.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < self.transactionsByDates.keys.count {
            let dateKey = self.transactionsByDates.sortedKeys[section]
            if let transactionsOfDate = self.transactionsByDates[dateKey] {
                return transactionsOfDate.count
            }
        }
        return 0;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transactionCell: TransactionCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.transactionCell) as! TransactionCell
        if indexPath.section < self.transactionsByDates.keys.count {
            let dateKey = self.transactionsByDates.sortedKeys[indexPath.section]
            if let transactionsOfDate = self.transactionsByDates[dateKey], indexPath.row < transactionsOfDate.count {
                transactionCell.refreshView(transaction: transactionsOfDate[indexPath.row])
            }
        }
        return transactionCell
    }
    
}

struct TableViewHeight {
    static let sectionHeader: CGFloat = 22.0
    static let cell: CGFloat = 44.0
}

extension AccountDetailDataSource: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader: DateSectionHeaderCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.dateSectionHeader) as! DateSectionHeaderCell
        if section < self.transactionsByDates.sortedKeys.count {
            let date = self.transactionsByDates.sortedKeys[section]
            sectionHeader.refreshView(date: date)
        }
        return sectionHeader.contentView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TableViewHeight.sectionHeader
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewHeight.cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let presentation = self.presentationDelegate, indexPath.section < self.transactionsByDates.keys.count {
            let dateKey = self.transactionsByDates.sortedKeys[indexPath.section]
            if let transactionsOfDate = self.transactionsByDates[dateKey], indexPath.row < transactionsOfDate.count {
                let transaction = transactionsOfDate[indexPath.row]
                if let atmId = transaction.atmId,
                    let atmDetail = self.atms.filter({ atm -> Bool in atm.id == atmId}).first,
                    let location = atmDetail.location {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let locationViewController = storyboard.instantiateViewController(withIdentifier: "ATMLocationViewController") as! ATMLocationViewController
                    let atmAnnotation = ATMAnnotation(coordinate: location.coordinate, title: atmDetail.name)
                    locationViewController.atmAnnotations = [atmAnnotation]
                    presentation.navigationController?.pushViewController(locationViewController, animated: true)
                }
            }
        }
    }
    
}
