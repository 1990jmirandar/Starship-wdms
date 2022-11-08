//
//  ManagmentFlowCapacity.swift
//  
//
//  Created by idukay on 8/11/22.
//

import Foundation
enum ShipOperationEnum: String{
    case Error = "Error"
    case Infinito = "Infinito"
    case Minute90 = "90 Minutos"
    case Minute80 = "80 Minutos"
    case Minute50 = "50 Minutos"
    case Minute0 = "0 Minutos"
}
struct ResultShipOperation{
    let shipOperationResult: ShipOperationEnum
    let mgInyectors:[Int]
}
class ManagmentFlowCapacity{
    let maximumFlowCapacity = MaximumFlowCapacity()
    let timeMaximumFlowCapacity = TimeMaximumFlowCapacity()
    func getShipOperationgTime(damages: [Int], velocityPercent: Int) -> ResultShipOperation{
        let realInjectorCapacity = damages.map{ damage in
            let valueMaximumFlowCapacity = maximumFlowCapacity.getMaximumFlowCapacity(damage: damage)
            return valueMaximumFlowCapacity
        }.filter{ capacity in
            if capacity <= 0 {
                return false
            }else{
                return true
            }
        }
        var percentVelocityLightCalculate = 0
        realInjectorCapacity.forEach{ capacity in
            percentVelocityLightCalculate += capacity
        }
        percentVelocityLightCalculate = percentVelocityLightCalculate / realInjectorCapacity.count
        if (realInjectorCapacity.count != damages.count){
            return resultWhenLostAInjectors(percentVelocityLightCalculate, velocityPercent, realInjectorCapacity, totalInjectors: damages.count)
        }else if (velocityPercent <  percentVelocityLightCalculate){
            return resultWhenVelocityIsSmallerThanPercentVelocityCalculate(percentVelocityLightCalculate, velocityPercent, realInjectorCapacity)
        }else if (velocityPercent > percentVelocityLightCalculate){
            return resultWhenVelocityIsMoreThanPercentVelocityCalculate(velocityPercent, percentVelocityLightCalculate, realInjectorCapacity)
        }
        if (percentVelocityLightCalculate == velocityPercent){
            let resultShipOperation = ResultShipOperation(shipOperationResult: ShipOperationEnum.Infinito, mgInyectors: realInjectorCapacity)
            return resultShipOperation
        }else{
            let resultShipOperation = ResultShipOperation(shipOperationResult: ShipOperationEnum.Error, mgInyectors: [])
            return resultShipOperation
        }
    }
    
    func getShipOperationByMinutesConsumed(minutesConsumed: Int) -> ShipOperationEnum{
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
        case 0 :
            shipOperation = ShipOperationEnum.Minute0
            break
        default:
            shipOperation = ShipOperationEnum.Error
        }
        return shipOperation
    }
    
    fileprivate func resultWhenVelocityIsMoreThanPercentVelocityCalculate(_ velocityPercent: Int, _ percentVelocityLightCalculate: Int, _ realInjectorCapacity: [Int]) -> ResultShipOperation {
        let missing = velocityPercent - percentVelocityLightCalculate
        let modifyInjectorsCapacity = realInjectorCapacity.map{ capacity in
            if missing > TimeMaximumFlowCapacity.valueTimeMaximumMGExtra{
                return 0
            }else{
                return capacity + missing
            }
        }.filter({ capacity in
            if capacity <= 0 {
                return false
            }else{
                return true
            }
        })
        let minutesConsumed = timeMaximumFlowCapacity.getTimeOfInyectorByMGExtra(mgExtra: missing)
        let shipOperation = getShipOperationByMinutesConsumed(minutesConsumed: minutesConsumed)
        let resultShipOperation = ResultShipOperation(shipOperationResult: shipOperation, mgInyectors: modifyInjectorsCapacity)
        return resultShipOperation
    }
    
    fileprivate func resultWhenVelocityIsSmallerThanPercentVelocityCalculate(_ percentVelocityLightCalculate: Int, _ velocityPercent: Int, _ realInjectorCapacity: [Int]) -> ResultShipOperation {
        let excess = percentVelocityLightCalculate - velocityPercent
        let modifyInjectorsCapacity = realInjectorCapacity.map{ capacity in
            return capacity - excess
        }
        let resultShipOperation = ResultShipOperation(shipOperationResult: ShipOperationEnum.Infinito, mgInyectors: modifyInjectorsCapacity)
        return resultShipOperation
    }
    
    fileprivate func resultWhenLostAInjectors(_ velocityPercent: Int, _ percentVelocityLightCalculate: Int, _ realInjectorCapacity: [Int], totalInjectors: Int) -> ResultShipOperation {
        let missing = velocityPercent - percentVelocityLightCalculate
        var modifyInjectorsCapacity = realInjectorCapacity.map{ capacity in
            return capacity + missing
        }
        let injectorsLost = totalInjectors - realInjectorCapacity.count
        (1...injectorsLost).forEach({ element in
            modifyInjectorsCapacity.append(0)
        })
        let minutesConsumed = timeMaximumFlowCapacity.getTimeOfInyectorByMGExtra(mgExtra: missing)
        let shipOperation = getShipOperationByMinutesConsumed(minutesConsumed: minutesConsumed)
        let resultShipOperation = ResultShipOperation(shipOperationResult: shipOperation, mgInyectors: modifyInjectorsCapacity)
        return resultShipOperation
    }
}
