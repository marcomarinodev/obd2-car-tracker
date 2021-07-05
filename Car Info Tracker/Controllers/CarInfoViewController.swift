//
//  ViewController.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 25/06/21.
//

import UIKit

class CarInfoViewController: UIViewController {
    
    internal var modeType: ModeType? = nil

    public var UIStrategy: CarInfoDrawer!

    // Using Liskov Principle
    private var UI: UIView!
    
    private var isFirstFetching = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        isFirstFetching = true
    }
    
    private func getData(of endpoint: Endpoint?) {
        
        if (endpoint != nil)
        {
            
            CarInfoGroup.getDataOf(endpoint: endpoint!) { [self] group in
                
                for i in group.attributes {
                    print("Parameter: \(i.name)\nValue: \(i.value ?? "")\nType: \(i.infoType.rawValue)\n")
                    
                }
                
                if isFirstFetching {
                    // First time: we need to rewrite the UI
                    // we do not really care about how the UI is represented
                    UI = self.UIStrategy.drawCarInfoUI(group)
                } else {
                    // Not the first time: just update UI DataSource
                    isFirstFetching = false
                    self.UIStrategy.updateCarInfoUI(group)
                }
                
                
            }
        } else {
            // simply no endpoint was chosen
            print("no endpoint was chosen")
        }
        
    }


}

extension CarInfoViewController: SelectModeViewControllerDelegate {
    
    func selectModeViewController(didCurrentInfoPressed request: Endpoint, mode: ModeType) {
        
        // setting the mode in order to update UI
        self.modeType = mode
        
        print("performing \(request.rawValue) request")
        
        // attempt trying to get data
        getData(of: request)
    }
    
    func selectModeViewController(didHystoricalInfoPressed hystoricalInfoType: HystoricalInfoType, mode: ModeType) {
        
        self.modeType = mode
        
        print("performing hystorical request")
    }
    
    
}

