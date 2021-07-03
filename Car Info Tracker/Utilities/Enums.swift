//
//  Enums.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 03/07/21.
//

import Foundation

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
 Enum representing the hystorical selected mode
 */
public enum HystoricalInfoType: String {
    case Plot = "Plot"
    case Predictions = "Predicts"
}

/**
 Enum that represents possible endpoints
 */

/*
 I can extend the endpoint enum without changing anything
 */
public enum Endpoint: String {
    case All = ""
    case Engine = "/engine_codes"
    case Chassis = "/chassis_codes"
    case ErrorCodes = "/error_codes"
    case Other = "/other_codes"
}
