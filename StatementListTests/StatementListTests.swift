//
//  StatementListTests.swift
//  StatementListTests
//
//  Created by Shelton Han on 19/12/16.
//  Copyright © 2016 Shelton Han. All rights reserved.
//

import XCTest
@testable import StatementList

class StatementListTests: XCTestCase {
    
    var dataManipulator: AccountDetailDataManipulator?
    
    override func setUp() {
        super.setUp()
        
        guard let pathToFile = Bundle.main.path(forResource: "exercise", ofType: "json") else {return}
        guard let exerciseData = NSData(contentsOfFile: pathToFile) else {return}
        
        do {
            let dataDict: [String: AnyObject] = try JSONSerialization.dictionary(data: exerciseData as Data, options: .allowFragments) as! [String : AnyObject]
            self.dataManipulator = AccountDetailDataManipulator(withDictionary: dataDict)
        }
        catch let error {
            print("Data Error: \(error)")
        }
        


        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
