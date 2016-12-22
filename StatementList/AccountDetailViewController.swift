//
//  AccountDetailViewController.swift
//  StatementList
//
//  Created by Shelton Han on 19/12/16.
//  Copyright © 2016 Shelton Han. All rights reserved.
//

import UIKit
import Alamofire

struct UrlPaths {
    static let dataUrl = "https://www.dropbox.com/s/tewg9b71x0wrou9/data.json?dl=1"
}

extension JSONSerialization {
    
    enum Errors: Error {
        case NotDictionary
        case NotJSONFormat
    }
    
    public class func dictionary(data: Data, options opt: JSONSerialization.ReadingOptions) throws -> NSDictionary {
        do {
            let JSON = try JSONSerialization.jsonObject(with: data , options:opt)
            if let JSONDictionary = JSON as? NSDictionary {
                return JSONDictionary
            }
            throw Errors.NotDictionary
        }
        catch {
            throw Errors.NotJSONFormat
        }
    }
}

class AccountDetailViewController: UITableViewController {
    
    var accountDataSource: AccountDetailDataSource?
    @IBOutlet weak var spendingButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let emptyDataHeader = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.emptyDataHeader)
        tableView.tableHeaderView = emptyDataHeader
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        refreshData()
    }
    
    func refreshData() {
        Alamofire.request(UrlPaths.dataUrl).responseJSON { response in
            if let responseData = response.data {
                do {
                    let responseDict = try JSONSerialization.dictionary(data: responseData, options: .allowFragments)
                    self.accountDataSource = AccountDetailDataSource(withDictionary: responseDict as! [String: AnyObject])
                    self.accountDataSource!.setupTableView(self.tableView, presentationDelegate: self)
                    
                    self.spendingButton.isEnabled = true
                    
                } catch let error {
                    print("\(error)")
                }

            } else {
                let alertController = UIAlertController(title: "Network Error", message: "Network error occured, please try again later.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

}

struct SegueIdentifiers {
    static let spendingView = "PresentSpendingView"
    static let atmMapView = "PresentAtmMapView"
}

extension AccountDetailViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
            case SegueIdentifiers.spendingView:
                let spendingViewController = (segue.destination as! UINavigationController).visibleViewController as! SpendingPredictionViewController
                spendingViewController.predicatedSpending = self.accountDataSource?.predicatedSpending()
            
            default: break
        }
    }
}












