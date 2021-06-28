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
     It converts endpoint taken from controller into a real endpoint (server-side)
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
            CarInfo(unit: .UnitCelsius, name: "Fuel Status", value: "Open loop due to insufficient engine temperature"),
            CarInfo(unit: .UnitKPH, name: "Speed", value: "0 KM/H"),
            CarInfo(unit: .UnitRPM, name: "RPM", value: "650 RPM"),
            CarInfo(unit: .UnitkPA, name: "Fuel Pressure", value: "413 kPA"),
            CarInfo(unit: .UnitkPA, name: "Intake Pressure", value: "74.5 kPA"),
        ]
        
        return CarInfoGroup(name: "Engine", attributes: info, dateTime: Date())
        
    }
    
    // JSON STRUCTURE
    /**
     {
         "all": {
             "error_codes": {
                 
             },
             
             "engine_codes": {
                 "FUEL_PRESSURE": {
                     "unit" : "Unit.kPA",
                     "value": 413.2
                 }
             },
                 
             "other_codes": {
                     
             }
         }
     }
     */
    
    /* MARK: - Real Data */
    /* @escaping keyword let the closure executes asynchronously on dispatch queue
     * that will hold the closure in memory, to be used in future
     */
    public static func getDataOf(endpoint ep: Endpoint, completion: @escaping (CarInfoGroup) -> Void) {
        
        let endp = convertEndpoint(ep)
        let ref = Database.database().reference().child("all\(endp)")
        
        // for now the trouble codes are absent
        var carInfoGroup = CarInfoGroup(name: endp, attributes: [], dateTime: Date())
        
        /* retrieving data when data is changing inside the specified endpoint */
        ref.observe(DataEventType.value) { (snapshot) in
            
            // start with empty array
            carInfoGroup.attributes.removeAll()
            
            if snapshot.exists() {
                /* Parsing the snapshot to a CarInfoGroup Data type */
                
                for child in snapshot.children {
                    
                    if let snapshot = child as? DataSnapshot,
                       let carInfoItem = CarInfo(snapshot: snapshot) {
                        
                        carInfoGroup.attributes.append(carInfoItem)
                        
                    }
                    
                }
                
                completion(carInfoGroup)
                
            } else {
                print("No data available at 'all\(endp)'")
            }
        }
        
    }
    
    
    
}
