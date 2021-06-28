//
//  CarInfoModel.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 25/06/21.
//

import Foundation
import FirebaseDatabase

/**
 Enum representing obd response value types with String as raw value
 
 + StringLiteral "" (fuel status, air status, ...)
 + Percent % (fuel level, evaporative_purge, ...)
 + Celsius °C (intake temp, catalyst temp, ...)
 + RPM
 + KPH
 + kPA (fuel pressure, intake pressure, ...)
 + Volt (Oxygen Bank n - Sensor k voltage, ...)
 + KM (Distance traveled since codes cleared, ...)
 + mA (Oxygen Sensor 1 WR Lambda Current, ...)
 */
public enum ObdValueType: String {
    case None = "none"
    case UnitPercent = "u.percent"
    case UnitCelsius = "u.celsius"
    case UnitRPM = "u.rpm"
    case UnitKPH = "u.kph"
    case UnitkPA = "u.kpa"
    case UnitVolt = "u.volt"
    case UnitKM = "u.km"
    case UnitMA = "u.ma"
    case UnitL = "u.l"
}

/**
 It represents a single car info containings:
 
 + infoType: kind of information about the car
 + name: information name (unique)
 + value: possible value associated with the info
 
 */
public struct CarInfo {
    public var infoType: ObdValueType
    public var name: String
    public var value: Any?
    
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
                        
                        self.value = numericalInfo
                    
                    } else {
                        print("cannot convert info as numerical (unit info)")
                        
                        return nil
                    }
                    
                } else {
                    // unit string does not contain Unit ==> value field is alfanumeric
                    
                    // error checking
                    if let stringInfo = infoAny as? NSString {
                        
                        self.value = stringInfo
                        
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
    
    public func toAnyObject() -> Any {
        return [
            "unit": infoType.rawValue,
            "value": value
        ]
    }
    
}
