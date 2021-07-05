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
    
    var modeType: ModeType
    
    public static func getModes() -> [Mode] {
        
        return [
            Mode(name: "Engine", endpoint: "/engine_codes", imageName: "engine", modeType: .endpoint),
            Mode(name: "Chassis", endpoint: "/chassis_codes", imageName: "chassis", modeType: .endpoint),
            Mode(name: "Plots", endpoint: "/plots", imageName: "plots", modeType: .hystorical),
            Mode(name: "Troubles", endpoint: "/error_codes", imageName: "trouble", modeType: .endpoint),
            Mode(name: "History", endpoint: "/history", imageName: "history", modeType: .hystorical),
            Mode(name: "Settings", endpoint: "/settings", imageName: "settings", modeType: .settings)
        ]
        
    }
    
}
