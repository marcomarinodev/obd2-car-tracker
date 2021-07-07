//
//  CarInfoModel.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 25/06/21.
//

import Foundation
import FirebaseDatabase

/**
 It represents a single car info containings:
 
 + infoType: kind of information about the car
 + name: information name (unique)
 + value: possible value associated with the info
 
 */
public struct CarInfo: Hashable {
    
    public var infoType: ObdValueType
    public var name: String
    public var value: String?
    
    init(unit infoType: ObdValueType, name: String, value: String?) {
        self.infoType = infoType
        self.name = name
        self.value = (value == nil) ? "" : value
    }
    
    
    init?(item: Dictionary<String, AnyObject>.Element) {
        // the key is always a string
        self.name = item.key
        
        if let valueData = item.value as? String {
        
            // trouble codes
            self.value = valueData
            self.infoType = .None
        
        } else {
            
            // normal codes
            // convert unit as string
            if let unit = item.value["unit"] as? String {
                
                self.infoType = ObdValueType(rawValue: unit)!
                
                // taking infoAny as AnyObject value
                let infoAny = item.value["value"]
                
                // if the unit string contains Unit ==> value field is numerical
                if (unit.contains("Unit") == true) {
                    
                    // error checking
                    if let numericalInfo = infoAny as? NSNumber {
                        
                        self.value = "\(numericalInfo)"
                    
                    } else {
                        print("cannot convert info as numerical (unit info)")
                        
                        return nil
                    }
                    
                } else {
                    // unit string does not contain Unit ==> value field is alfanumeric
                    
                    // error checking
                    if let stringInfo = infoAny as? NSString {
                        
                        self.value = "\(stringInfo)"
                        
                    } else {
                        
                        print("cannot convert string info as string (alfanumeric info))")
                        
                        return nil
                        
                    }
                }
            } else {
                print("cannot convert unit to string (really strange)")
                
                return nil
            }
            
        }
        
    }
    
    // to conform to the Hashable protocol we have to say when two
    // CarInfo object are equal
    public static func == (lhs: CarInfo, rhs: CarInfo) -> Bool {
        lhs.name == rhs.name && lhs.value == rhs.value
    }
    
}
