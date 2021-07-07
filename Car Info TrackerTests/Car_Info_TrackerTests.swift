//
//  Car_Info_TrackerTests.swift
//  Car Info TrackerTests
//
//  Created by Marco Marinò on 25/06/21.
//

import XCTest
@testable import Car_Info_Tracker

class Car_Info_TrackerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    /// This is the initial situation when the old car info group is empty and data are fetched for the first time
    /// - Throws: Error due to XCTAssertEqual between computed diff set and the expected one
    func testInitialDiffFetching() {
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
    
    func testNoDiffFetching() {
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
