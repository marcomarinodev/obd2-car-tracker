//
//  Mode.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 29/06/21.
//

import Foundation

public struct Mode {
    
    public var name: String
    public var imageName: String
    
    enum ModeType {
        case endpoint
        case hystorical
    }
    
    var modeType: ModeType
    
    public static func getModes() -> [Mode] {
        
        return [
            Mode(name: "/engine_codes", imageName: "engine", modeType: .endpoint),
            Mode(name: "/chassis_codes", imageName: "chassis", modeType: .endpoint),
            Mode(name: "/error_codes", imageName: "trouble", modeType: .endpoint),
            Mode(name: "Plot", imageName: "telemetry", modeType: .hystorical),
            Mode(name: "Predicts", imageName: "history", modeType: .hystorical)
        ]
        
    }
    
}
