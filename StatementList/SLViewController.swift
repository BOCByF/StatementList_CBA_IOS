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

struct TextColors {
    static let black = UIColor(red:35/255, green:31/255, blue:32/255, alpha:1.0)
}

struct TextFonts {
    static let regularText = UIFont(name: "HelveticaNeue", size: 12)
    static let boldText = UIFont(name: "HelveticaNeue-Bold", size: 12)
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

