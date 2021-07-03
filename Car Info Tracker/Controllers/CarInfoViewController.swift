//
//  ViewController.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 25/06/21.
//

import UIKit

class CarInfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }
    
    private func getData(of endpoint: Endpoint?) {
        
        if (endpoint != nil)
        {
            CarInfoGroup.getDataOf(endpoint: endpoint!) { group in
                print("\nGROUP INFO")
                for i in group.attributes {
                    print("Parameter: \(i.name)\nValue: \(i.value ?? "")\nType: \(i.infoType.rawValue)\n")
                }
            }
        } else {
            // simply no endpoint was chosen
            print("no endpoint was chosen")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toInfo" {
                if let selectVC = segue.destination as? SelectModeViewController {
                    
                    selectVC.delegate = self
                    
                }
            }
        }
    }


}

extension CarInfoViewController: SelectModeViewControllerDelegate {
    
    func selectModeViewController(didCurrentInfoPressed request: Endpoint) {
        
        print("performing \(request.rawValue) request")
        
        // attempt trying to get data
        getData(of: request)
    }
    
    func selectModeViewController(didHystoricalInfoPressed hystoricalInfoType: HystoricalInfoType) {
        
        print("performing hystorical request")
    }
    
    
}

