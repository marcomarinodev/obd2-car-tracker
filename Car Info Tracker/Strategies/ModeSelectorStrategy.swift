//
//  ModeSelectorStrategy.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 29/06/21.
//

import UIKit

// Mode Selector Strategy: it defines a method to draw a view based on mode selected in SelectModelViewController
public protocol ModeSelectorStrategy: AnyObject {
    
    var title: String { get }
    
    func produceView() -> UIView
    
}
