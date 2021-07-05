//
//  CarInfoDrawer.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 04/07/21.
//

import UIKit

public protocol CarInfoDrawer: AnyObject {
    
    /**
        Function that draw the UI based on data received from the database
     */
    func drawCarInfoUI(_ group: CarInfoGroup) -> UIView
    
    /**
        Function that updates UI data based on model update
     */
    func updateCarInfoUI(_ group: CarInfoGroup)
    
}
