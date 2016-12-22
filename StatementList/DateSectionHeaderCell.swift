//
//  DateSectionHeaderCell.swift
//  StatementList
//
//  Created by Shelton Han on 21/12/16.
//  Copyright © 2016 Shelton Han. All rights reserved.
//

import Foundation
import UIKit

class DateSectionHeaderCell: UITableViewCell {
    static var dateFormatter = DateFormatter()
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var daysSince: UILabel!
    
    // Refresh cell with data, sicnce this method updates all subviews that can change, it doesn't need to explicitly "return to clear" state 
    func refreshView(date: Date) {
        // Date Label on left
        DateSectionHeaderCell.dateFormatter.dateFormat = "dd MMM yyyy"
        self.date!.text = DateSectionHeaderCell.dateFormatter.string(from: date)
        
        // DaySince Label on right, showing days since now 
        if let day = Calendar.current.dateComponents([Calendar.Component.day], from: date, to: Date()).day {
            self.daysSince!.text = "\(day) \(day > 1 ? "Days" : "Day") Ago"
        } else {
            self.daysSince!.text = "Today"
        }
        
    }
    
}
