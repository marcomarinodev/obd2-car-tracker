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
 + status: an integer showing the number of troubles in this group
 */
public struct CarInfoGroup {
    public let name: String
    public let attributes: [CarInfo]
    public let status: Int
}
