//
//  CarInfoDrawer.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 04/07/21.
//

import UIKit

public protocol CarInfoDrawer: AnyObject {
    
    
    /// It draws the car info UI
    /// - Parameters:
    ///   - group: car info group
    ///   - response: server response
    ///   - mainView: reference to mainView
    ///   - tableView: reference to the tableView that belongs to mainView
    ///   - titleLabel: reference to the titleLabel that belongs to mainView
    func drawCarInfoUI(of group: CarInfoGroup, with response: FetchingResponse, on mainView: inout UIView, _ tableView: inout UITableView, _ titleLabel: inout UILabel)
    
    /**
        Function that updates UI data based on model update
     */
    func updateCarInfoUI(_ group: CarInfoGroup)
    
}
