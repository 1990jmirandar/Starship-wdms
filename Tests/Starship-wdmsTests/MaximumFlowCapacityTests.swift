//
//  MaximumFlowCapacity.swift
//  
//
//  Created by idukay on 7/11/22.
//

import XCTest
@testable import Starship_wdms
final class MaximumFlowCapacityTests: XCTestCase {
    var main: MaximumFlowCapacity!
    override func setUpWithError() throws {
        main = MaximumFlowCapacity()
    }

    func testWhenTheInjectorFailsAt0Percent() throws {
        let valuePlasma = main.getMaximumFlowCapacity(damage: 0)
        assert(valuePlasma == 100)
    }
    
    func testWhenTheInjectorFailsAt30Percent() throws {
        let valuePlasma = main.getMaximumFlowCapacity(damage: 30)
        assert(valuePlasma == 70)
    }
    
    func testWhenTheInjectorFailsAt80Percent() throws {
        let valuePlasma = main.getMaximumFlowCapacity(damage: 80)
        assert(valuePlasma == 20)
    }
    
    func testWhenTheInjectorFailsAt100Percent() throws {
        let valuePlasma = main.getMaximumFlowCapacity(damage: 100)
        assert(valuePlasma == 0)
    }
    
}
