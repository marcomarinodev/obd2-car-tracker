//
//  CarInfoVCUnitTests.swift
//  Car Info TrackerTests
//
//  Created by Marco Marinò on 07/07/21.
//

import XCTest
@testable import Car_Info_Tracker

class CarInfoVCUnitTests: XCTestCase {

    override class func setUp() {
        super.setUp()
    }

    override class func tearDown() {
        super.tearDown()
    }
    
    // MARK: Testing detectDifferencesAndDo method
    /// This is the initial situation when the old car info group is empty and data are fetched for the first time
    /// - Throws: Error due to XCTAssertEqual between computed diff set and the expected one
    func testInitialDiffFetching() throws {
        let vc = CarInfoViewController()
        
        let emptyGroup = CarInfoGroup(name: "Engine", attributes: [], dateTime: Date())
        let newGroup = CarInfoGroup(
            name: "Engine",
            attributes: [
                CarInfo(unit: .UnitPercent, name: "Fuel Level", value: "56"),
                CarInfo(unit: .UnitKPH, name: "Speed", value: "23.4"),
                CarInfo(unit: .UnitCelsius, name: "Engine Temperature", value: "100")
            ],
            dateTime: Date()
        )
        
        var expectedResult = Set<CarInfo>()
        
        expectedResult.insert(CarInfo(unit: .UnitPercent, name: "Fuel Level", value: "56"))
        expectedResult.insert(CarInfo(unit: .UnitKPH, name: "Speed", value: "23.4"))
        expectedResult.insert(CarInfo(unit: .UnitCelsius, name: "Engine Temperature", value: "100"))
        
        vc.callDetectDifferences(old: emptyGroup, new: newGroup) { diff in
            XCTAssertEqual(diff, expectedResult)
        }
    }
    
    /// This tests the situation when there is no difference, but this situation should never happen because the old group
    /// should change only when there's an update in realtime database
    /// - Throws: Error due to XCTAssertEqual between computed diff set and the expected one
    func testNoDiffFetching() throws {
        let vc = CarInfoViewController()
        
        let oldGroup = CarInfoGroup(
            name: "Engine",
            attributes: [
                CarInfo(unit: .UnitPercent, name: "Fuel Level", value: "56"),
                CarInfo(unit: .UnitKPH, name: "Speed", value: "23.4"),
                CarInfo(unit: .UnitCelsius, name: "Engine Temperature", value: "100")
            ],
            dateTime: Date()
        )
        
        let newGroup = CarInfoGroup(
            name: "Engine",
            attributes: [
                CarInfo(unit: .UnitPercent, name: "Fuel Level", value: "56"),
                CarInfo(unit: .UnitKPH, name: "Speed", value: "23.4"),
                CarInfo(unit: .UnitCelsius, name: "Engine Temperature", value: "100")
            ],
            dateTime: Date()
        )
        
        let expectedResult = Set<CarInfo>()
        
        vc.callDetectDifferences(old: oldGroup, new: newGroup) { diff in
            XCTAssertEqual(diff, expectedResult)
        }
    }
    
    /// This tests the normal situation, when there are value changes
    /// - Throws: Error due to XCTAssertEqual between computed diff set and the expected one
    func testDiffFetching() throws {
        let vc = CarInfoViewController()
        
        let oldGroup = CarInfoGroup(
            name: "Engine",
            attributes: [
                CarInfo(unit: .UnitPercent, name: "Fuel Level", value: "56"),
                CarInfo(unit: .UnitKPH, name: "Speed", value: "23.4"),
                CarInfo(unit: .UnitCelsius, name: "Engine Temperature", value: "100")
            ],
            dateTime: Date()
        )
        
        let newGroup = CarInfoGroup(
            name: "Engine",
            attributes: [
                CarInfo(unit: .UnitPercent, name: "Fuel Level", value: "56"),
                CarInfo(unit: .UnitKPH, name: "Speed", value: "16.4"),
                CarInfo(unit: .UnitCelsius, name: "Engine Temperature", value: "80")
            ],
            dateTime: Date()
        )
        
        var expectedResult = Set<CarInfo>()
        
        expectedResult.insert(CarInfo(unit: .UnitKPH, name: "Speed", value: "16.4"))
        expectedResult.insert(CarInfo(unit: .UnitCelsius, name: "Engine Temperature", value: "80"))
        
        vc.callDetectDifferences(old: oldGroup, new: newGroup) { diff in
            XCTAssertEqual(diff, expectedResult)
        }
    }
    
}
