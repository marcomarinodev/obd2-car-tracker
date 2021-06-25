//
//  CarInfoGroupData.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 25/06/21.
//

import Foundation

extension CarInfoGroup {
    
    /* mock data */
    public static func sampleEngine() -> CarInfoGroup {
        
        let info = [
            CarInfo(infoType: .UnitCelsius, name: "Fuel Status", value: "Open loop due to insufficient engine temperature"),
            CarInfo(infoType: .UnitKPH, name: "Speed", value: "0 KM/H"),
            CarInfo(infoType: .UnitRPM, name: "RPM", value: "650 RPM"),
            CarInfo(infoType: .UnitkPA, name: "Fuel Pressure", value: "413 kPA"),
            CarInfo(infoType: .UnitkPA, name: "Intake Pressure", value: "74.5 kPA"),
        ]
        
        return CarInfoGroup(name: "Engine", attributes: info, status: 2)
        
    }
    
    /* real data from server */
    
    
}
