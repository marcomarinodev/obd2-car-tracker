//
//  CarInfoModel.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 25/06/21.
//

import Foundation


/**
 Enum representing obd response value types
 
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
public enum ObdValueType {
    case StringLiteral
    case UnitPercent
    case UnitCelsius
    case UnitRPM
    case UnitKPH
    case UnitkPA
    case UnitVolt
    case UnitKM
    case UnitMA
}

/**
 It represents a single car info containings:
 
 + infoType: kind of information about the car
 + name: information name (unique)
 + value: possible value associated with the info
 
 */
public struct CarInfo {
    public let infoType: ObdValueType
    public let name: String
    public let value: String?
}
