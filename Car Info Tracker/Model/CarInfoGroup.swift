//
//  CarInfoGroup.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 25/06/21.
//

import Foundation

/**
 It represents a collection of information about a specific group, for example: engine, chassis, ...
 
 + name: group name
 + attributes: collection of info about this group
 */
public struct CarInfoGroup {
    
    public var name: String
   
    public var attributes: [CarInfo]
    
    public let dateTime: Date
    
    public var description: String {
        switch name {
        case "/engine_codes":
            return "Engine"
        case "/chassis_codes":
            return "Chassis"
        case "/error_codes":
            return "Troubles"
        default:
            return "Engine"
        }
    }
    
    public init() {
        self.name = ""
        self.attributes = []
        self.dateTime = Date()
    }
    
    public init(name: String, attributes: [CarInfo], dateTime: Date) {
        self.name = name
        self.attributes = attributes
        self.dateTime = dateTime
    }
}
