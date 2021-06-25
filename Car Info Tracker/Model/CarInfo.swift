//
//  CarInfoModel.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 25/06/21.
//

import Foundation


/**
 Enum representing obd response value types
 
 - StringLiteral "" (fuel status, air status, ...)
 - Percent % (fuel level, evaporative_purge, ...)
 - Celsius °C (intake temp, catalyst temp, ...)
 - RPM
 - KPH
 - kPA (fuel pressure, intake pressure, ...)
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
 It represents a single car info
 
 */

public struct CarInfo {
    public let name: String
    
    public let value: String?
}
