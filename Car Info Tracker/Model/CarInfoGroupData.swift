//
//  CarInfoGroupData.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 25/06/21.
//

import Foundation
import FirebaseDatabase

/**
 Enum that represents possible endpoints
 */
public enum Endpoint {
    case All
    case Engine
    case Chassis
    case ErrorCodes
}

extension CarInfoGroup {
    
    /**
     it converts endpoint taken from controller into a real endpoint (server-side)
     */
    private static func convertEndpoint(_ endpoint: Endpoint) -> String {
        switch endpoint {
        case .All:
            return ""
        case .Engine:
            return "/engine_codes"
        case .Chassis:
            return "/other_codes"
        case .ErrorCodes:
            return "/error_codes"
        }
    }
    
    /* MARK: - Mock Data */
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
    
    /* MARK: - Real Data */
    public static func getDataOf(endpoint ep: Endpoint) -> CarInfoGroup? {
        
        let endp = convertEndpoint(ep)
        
        let ref = Database.database().reference()
        
        /* retrieving data when data is changing inside the specified endpoint */
        _ = ref.child("all\(endp)").observe(DataEventType.value) { (snapshot) in
            // snapshot handler
            
            let snapshotValue = snapshot.value as? NSDictionary
            
            if snapshot.exists() {
                /* MARK: - TODO Parsing the snapshot to a CarInfoGroup Data type */
                
                // unwrapping because we're sure that snapshot exists
                print(snapshotValue!)
            } else {
                print("No data available at 'all\(endp)'")
            }
        }
        
        return nil
        
    }
    
    
    
}
