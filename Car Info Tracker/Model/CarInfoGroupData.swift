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
    static func checkConnection(completion: @escaping (Bool) -> Void) {
        
        /*
         * Firebase Realtime DB provides an endpoint /.info/connected which is
         * updated every time the DB client's connection state changes. It returns a boolean
         * value which is not synchronized between clients because the value is
         * dependent on the state of the this client. If one client reads this
         * endpoint as false, this is no guarantee that a separate client will
         * also read false.
         */
        let connectedRef = Database.database().reference(withPath: ".info/connected")
        
        connectedRef.observe(.value) { snapshot in
            if (snapshot.value as? Bool ?? false) {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    /* @escaping keyword let the closure executes asynchronously on dispatch queue
     * that will hold the closure in memory, to be used in future
     */
    public static func getDataOf(endpoint ep: Endpoint, completion: @escaping (CarInfoGroup, FetchingResponse) -> Void) {
        
        // check connection before do anything
        checkConnection { connected in
            if (connected) {
                print("connected")
                
                let endp = ep.rawValue
                let ref = Database.database().reference().child("all\(endp)")
                
                // for now the trouble codes are absent
                var carInfoGroup = CarInfoGroup(name: endp, attributes: [], dateTime: Date())
                
                /* retrieving data when data is changing inside the specified endpoint */
                ref.observe(DataEventType.value) { (snapshot) in
                    
                    print("DATABASE UPDATE")
                    
                    // start with empty array
                    carInfoGroup.attributes.removeAll()
                    
                    if snapshot.exists() {
                        /* Parsing the snapshot to a CarInfoGroup Data type */
                        
                        let dict = snapshot.value! as? [String: AnyObject]
                        
                        for child in dict! {
                            
                            print("\n\(child)\n")
                            
                            if let carInfoItem = CarInfo(item: child) {
                                
                                carInfoGroup.attributes.append(carInfoItem)
                                
                            }
                            
                        }
                        
                        completion(carInfoGroup, .Success)
                        
                    } else {
                        print("\nNo data available at 'all\(endp)'\n")
                        completion(CarInfoGroup.init(), .InvalidEndpoint)
                    }
                }
                
                
            } else {
                completion(CarInfoGroup.init(), .NotConnected)
            }
        }
        
        
        
    }
    
    
    
}
