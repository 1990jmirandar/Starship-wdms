//
//  ManagmentFlowCapacityTest.swift
//  
//
//  Created by idukay on 8/11/22.
//

import XCTest
@testable import Starship_wdms
final class ManagmentFlowCapacityTest: XCTestCase {
    var main: ManagmentFlowCapacity!
    
    override func setUpWithError() throws {
        main = ManagmentFlowCapacity()
    }

    func test0PercentDamageOfInjectorAnd100PercentVelocityLight() throws {
        let value = main.getShipOperationgTime(damages: [0,0,0], velocityPercent: 100)
        assert(value.shipOperationResult.rawValue == ShipOperationEnum.Infinito.rawValue && value.mgInyectors == [100,100,100])
    }
    
    func test0PercentDamageOfInjectorAnd90PercentVelocityLight() throws {
        let value = main.getShipOperationgTime(damages: [0,0,0], velocityPercent: 90)
        assert(value.shipOperationResult.rawValue == ShipOperationEnum.Infinito.rawValue && value.mgInyectors == [90,90,90])
    }
    
    func test0PercentDamageOfInjectorAnd30PercentVelocityLight() throws {
        let value = main.getShipOperationgTime(damages: [0,0,0], velocityPercent: 30)
        assert(value.shipOperationResult.rawValue == ShipOperationEnum.Infinito.rawValue && value.mgInyectors == [30,30,30])
    }
    
    func test20PercentDamageOfInjectorAAnd10PercentDamageOfInjectorBAnd0PercentDamageOfInjectorCAnd100PercentVelocityLight() throws {
        let value = main.getShipOperationgTime(damages: [20,10,0], velocityPercent: 100)
        assert(value.shipOperationResult.rawValue == ShipOperationEnum.Minute90.rawValue && value.mgInyectors == [90,100,110])
    }
    
    func test0PercentDamageOfInjectorAAnd0PercentDamageOfInjectorBAnd100PercentDamageOfInjectorCAnd80PercentVelocityLight() throws {
        let value = main.getShipOperationgTime(damages: [0,0,100], velocityPercent: 80)
        assert(value.shipOperationResult.rawValue == ShipOperationEnum.Minute80.rawValue && value.mgInyectors == [120,120,0])
    }
    
    func test0PercentDamageOfInjectorAAnd0PercentDamageOfInjectorBAnd0PercentDamageOfInjectorCAnd150PercentVelocityLight() throws {
        let value = main.getShipOperationgTime(damages: [0,0,0], velocityPercent: 150)
        assert(value.shipOperationResult.rawValue == ShipOperationEnum.Minute50.rawValue && value.mgInyectors == [150,150,150])
    }
    
    func test0PercentDamageOfInjectorAAnd0PercentDamageOfInjectorBAnd30PercentDamageOfInjectorCAnd140PercentVelocityLight() throws {
        let value = main.getShipOperationgTime(damages: [0,0,30], velocityPercent: 140)
        assert(value.shipOperationResult.rawValue == ShipOperationEnum.Minute50.rawValue && value.mgInyectors == [150,150,120])
    }
    
    func test20PercentDamageOfInjectorAAnd50PercentDamageOfInjectorBAnd40PercentDamageOfInjectorCAnd170PercentVelocityLight() throws {
        let value = main.getShipOperationgTime(damages: [29,50,40], velocityPercent: 170)
        assert(value.shipOperationResult.rawValue == ShipOperationEnum.Minute0.rawValue && value.mgInyectors == [])
    }
}
