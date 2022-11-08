//
//  TimeMaximuFlowCapacityTest.swift
//  
//
//  Created by idukay on 8/11/22.
//

import XCTest
@testable import Starship_wdms
final class TimeMaximuFlowCapacityTest: XCTestCase {
    var main: TimeMaximumFlowCapacity!
    override func setUpWithError() throws {
        main = TimeMaximumFlowCapacity()
    }

    func testTimeOfInyectorWith99MGExtra() throws {
        let value = main.getTimeOfInyectorByMGExtra(mgExtra: 99)
        assert(value == 1)
    }
    
    func testTimeOfInyectorWith80MGExtra() throws {
        let value = main.getTimeOfInyectorByMGExtra(mgExtra: 80)
        assert(value == 20)
    }
    //Equivalente a infinito
    func testTimeOfInyectorWith0MGExtra() throws {
        let value = main.getTimeOfInyectorByMGExtra(mgExtra: 0)
        assert(value == 100)
    }
    //Equivalente a que no va a funcionar el inyector
    func testTimeOfInyectorWith100MGExtra() throws {
        let value = main.getTimeOfInyectorByMGExtra(mgExtra: 100)
        assert(value == 0)
    }

}
