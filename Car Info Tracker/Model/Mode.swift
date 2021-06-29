//
//  Mode.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 29/06/21.
//

import Foundation

public struct Mode {
    
    public var name: String?
    public var imageName: String
    
    public static func getModes() -> [Mode] {
        
        return [
            Mode(name: "Engine", imageName: "engine"),
            Mode(name: "Chassis", imageName: "chassis"),
            Mode(name: "Troubles", imageName: "trouble"),
            Mode(name: "History", imageName: "history"),
            Mode(name: "Telemetry", imageName: "telemetry")
        ]
        
    }
    
}
