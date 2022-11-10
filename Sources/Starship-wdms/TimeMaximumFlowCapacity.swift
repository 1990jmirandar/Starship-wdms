//
//  TimeMaximumFlowCapacity.swift
//  
//
//  Created by idukay on 8/11/22.
//

import Foundation
class TimeMaximumFlowCapacity{
    static let valueTimeMaximumMGExtra = 99
    func getTimeOfInyectorByMGExtra(mgExtra: Int) -> Int{
        if (mgExtra > TimeMaximumFlowCapacity.valueTimeMaximumMGExtra){
            return 0
        }
        return 100 - mgExtra
    }
    
    static func getShipOperationByMinutesConsumed(minutesConsumed: Int) -> ShipOperationEnum{
        var shipOperation = ShipOperationEnum.Error
        switch(minutesConsumed){
        case 90:
            shipOperation = ShipOperationEnum.Minute90
            break
        case 80:
            shipOperation = ShipOperationEnum.Minute80
            break
        case 50:
            shipOperation = ShipOperationEnum.Minute50
            break
        default:
            shipOperation = ShipOperationEnum.Minute0
            break
        }
        return shipOperation
    }
}
