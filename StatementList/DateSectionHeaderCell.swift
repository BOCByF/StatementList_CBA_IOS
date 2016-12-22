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
    
    func refreshView(date: Date) {
        DateSectionHeaderCell.dateFormatter.dateFormat = "dd MMM yyyy"
        self.date!.text = DateSectionHeaderCell.dateFormatter.string(from: date)
        
        if let day = Calendar.current.dateComponents([Calendar.Component.day], from: date, to: Date()).day {
            self.daysSince!.text = "\(day) \(day > 1 ? "Days" : "Day") Ago"
        } else {
            self.daysSince!.text = "Today"
        }
        
    }
    
}
