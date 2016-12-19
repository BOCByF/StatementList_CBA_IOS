//
//  SLViewController.swift
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

struct ThemeColors {
    struct Background {
        static let blue = UIColor(red:146/255, green:176/255, blue:176/255, alpha:1.0)
        static let grey = UIColor(red:246/255, green:246/255, blue:246/255, alpha:1.0)
        static let yellow = UIColor(red:255/255, green:204/255, blue:0.0, alpha:1.0)
    }
    struct Text {
        static let grey = UIColor(red:138/255, green:138/255, blue:138/255, alpha:1.0)
        static let black = UIColor(red:35/255, green:31/255, blue:32/255, alpha:1.0)
    }
}

struct ThemeFont {
    static let heading = UIFont(name: "HelveticaNeue-Light", size: 18)
    static let normalText = UIFont(name: "HelveticaNeue-Light", size: 16)
    static let boldText = UIFont(name: "HelveticaNeue-Bold", size: 16)
}

class SLViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Alamofire.request(UrlPaths.dataUrl).responseJSON { response in
            if let data = response.result.value {
                print("data: \(data)")
            }
        }
    }


}

