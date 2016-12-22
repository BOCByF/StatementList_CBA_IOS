//
//  SpendingPredictionViewController.swift
//  StatementList
//
//  Created by Shelton Han on 22/12/16.
//  Copyright © 2016 Shelton Han. All rights reserved.
//

import Foundation
import UIKit

class SpendingPredictionViewController: UIViewController {
    
    public var predicatedSpending: NSNumber?
    @IBOutlet var spendingLabel: UILabel!
    
    @IBAction func dismissView() {
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        spendingLabel.text = AccountDetailHeaderCell.currencyFormatter.string(from: predicatedSpending ?? 0)
        
    }
    
}
