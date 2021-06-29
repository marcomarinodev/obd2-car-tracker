//
//  ViewController.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 25/06/21.
//

import UIKit

class CarInfoViewController: UIViewController {
    
    // MARK: - Strategy
    public var modeSelectorStrategy: ModeSelectorStrategy! {
        
        didSet {
            navigationItem.title = modeSelectorStrategy.title
        }
        
    }
    
    // MARK: - STUB
    var groupModel: CarInfoGroup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: - STUB
        CarInfoGroup.getDataOf(endpoint: .Engine) { group in
            print("\nGROUP INFO")
            for i in group.attributes {
                print("Parameter: \(i.name)\nValue: \(i.value ?? "")\nType: \(i.infoType.rawValue)\n")
            }
        }
    }


}

