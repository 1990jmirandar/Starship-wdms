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
}
