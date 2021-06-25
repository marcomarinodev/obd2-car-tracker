//
//  CarInfoGroupData.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 25/06/21.
//

import Foundation
import FirebaseDatabase

extension CarInfoGroup {
    
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
    public static func realEngine() -> CarInfoGroup? {
        
        let ref = Database.database().reference()
        
        _ = ref.observe(.value) { (snapshot) in
            // snapshot handler
            
            let snapshotValue = snapshot.value as? NSDictionary
            
            if snapshot.exists() {
                /* MARK: - TODO Parsing the snapshot to a CarInfoGroup Data type */
                
                // unwrapping because we're shire that snapshot exists
                print(snapshotValue!)
            } else {
                print("No data available")
            }
        }
        
        return nil
        
    }
    
}
