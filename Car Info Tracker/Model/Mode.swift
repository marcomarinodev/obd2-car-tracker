//
//  Mode.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 29/06/21.
//

import Foundation

public struct Mode {
    
    public var name: String
    public var endpoint: String
    public var imageName: String
    
    public static func getModes() -> [Mode] {
        
        return [
            Mode(name: "Engine", endpoint: "/engine_codes", imageName: "engine"),
            Mode(name: "Chassis", endpoint: "/chassis_codes", imageName: "chassis"),
            Mode(name: "Troubles", endpoint: "/error_codes", imageName: "trouble")
        ]
        
    }
    
}
