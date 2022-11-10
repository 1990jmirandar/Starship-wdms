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
    var percentVelocityLightCalculate = 0
    func getShipOperationgTime(damages: [Int], velocityPercent: Int) -> ResultShipOperation{
        let realInjectorCapacity = damages.map{ damage in maximumFlowCapacity.getMaximumFlowCapacity(damage: damage)
        }.filter{ capacity in capacity > 0}
        realInjectorCapacity.forEach{ capacity in percentVelocityLightCalculate += capacity }
        let ammountRealInjector = realInjectorCapacity.count
        let ammountDamages = damages.count
        percentVelocityLightCalculate = percentVelocityLightCalculate / ammountRealInjector
        if (ammountRealInjector != ammountDamages){
            return resultWhenLostAInjectors(percentVelocityLightCalculate, velocityPercent, realInjectorCapacity, totalInjectors: ammountDamages)
        }else if (velocityPercent <  percentVelocityLightCalculate){
            return velocityIsSmallerThanPercentCalculate(percentVelocityLightCalculate, velocityPercent, realInjectorCapacity)
        }else if (velocityPercent > percentVelocityLightCalculate){
            return velocityIsMoreThanPercentCalculate(velocityPercent, percentVelocityLightCalculate, realInjectorCapacity)
        }else {
            let resultShipOperation = ResultShipOperation(shipOperationResult: ShipOperationEnum.Infinito, mgInyectors: realInjectorCapacity)
            return resultShipOperation
        }
    }
    fileprivate func velocityIsMoreThanPercentCalculate(_ velocityPercent: Int, _ percentVelocityLightCalculate: Int, _ realInjectorCapacity: [Int]) -> ResultShipOperation {
        let missing = velocityPercent - percentVelocityLightCalculate
        let modifyInjectorsCapacity = realInjectorCapacity.map{ capacity in
            var result = 0
            if missing < TimeMaximumFlowCapacity.valueTimeMaximumMGExtra{
                result = capacity + missing
            }
            return result
        }.filter({ capacity in capacity > 0})
        let minutesConsumed = timeMaximumFlowCapacity.getTimeOfInyectorByMGExtra(mgExtra: missing)
        let shipOperation = TimeMaximumFlowCapacity.getShipOperationByMinutesConsumed(minutesConsumed: minutesConsumed)
        let resultShipOperation = ResultShipOperation(shipOperationResult: shipOperation, mgInyectors: modifyInjectorsCapacity)
        return resultShipOperation
    }
    fileprivate func velocityIsSmallerThanPercentCalculate(_ percentVelocityLightCalculate: Int, _ velocityPercent: Int, _ realInjectorCapacity: [Int]) -> ResultShipOperation {
        let excess = percentVelocityLightCalculate - velocityPercent
        let modifyInjectorsCapacity = realInjectorCapacity.map{ capacity in capacity - excess}
        let resultShipOperation = ResultShipOperation(shipOperationResult: ShipOperationEnum.Infinito, mgInyectors: modifyInjectorsCapacity)
        return resultShipOperation
    }
    fileprivate func resultWhenLostAInjectors(_ velocityPercent: Int, _ percentVelocityLightCalculate: Int, _ realInjectorCapacity: [Int], totalInjectors: Int) -> ResultShipOperation {
        let missing = velocityPercent - percentVelocityLightCalculate
        var modifyInjectorsCapacity = realInjectorCapacity.map{ capacity in
            return capacity + missing
        }
        let injectorsLost = totalInjectors - realInjectorCapacity.count
        (1...injectorsLost).forEach({ element in modifyInjectorsCapacity.append(0) })
        let minutesConsumed = timeMaximumFlowCapacity.getTimeOfInyectorByMGExtra(mgExtra: missing)
        let shipOperation = TimeMaximumFlowCapacity.getShipOperationByMinutesConsumed(minutesConsumed: minutesConsumed)
        let resultShipOperation = ResultShipOperation(shipOperationResult: shipOperation, mgInyectors: modifyInjectorsCapacity)
        return resultShipOperation
    }
}
