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
    public var value: String?
    
    init(unit infoType: ObdValueType, name: String, value: String?) {
        self.infoType = infoType
        self.name = name
        self.value = (value == nil) ? "" : value
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let snapVal = snapshot.value as? [String: AnyObject],
            let unit = snapVal["unit"] as? String,
            let value = snapVal["value"] as? String else {
            
            return nil
        }
        
        self.infoType = ObdValueType(rawValue: unit)!
        self.name = snapshot.key
        self.value = value
    }
    
    public func toAnyObject() -> Any {
        return [
            "unit": infoType.rawValue,
            "value": value
        ]
    }
    
}
