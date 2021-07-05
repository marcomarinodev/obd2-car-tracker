//
//  CurrentDataDrawer.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 05/07/21.
//

import UIKit

public class CurrentDataDrawer: CarInfoDrawer {
    
    // MARK: - Define Strategy
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func drawCarInfoUI(_ group: CarInfoGroup) -> UIView {
        let view = UIView()
    
        return view
    }
    
    public func updateCarInfoUI(_ group: CarInfoGroup) {
        
    }
    
}

