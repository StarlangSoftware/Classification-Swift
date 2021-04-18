//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class PairedTest {
    
    public func compare(classifier1: ExperimentPerformance, classifier2: ExperimentPerformance) -> StatisticalTestResult{
        return StatisticalTestResult(pValue: 0.0, onlyTwoTailed: false)
    }
    
    public func compareWithAlpha(classifier1: ExperimentPerformance, classifier2: ExperimentPerformance, alpha: Double) -> Int{
        let testResult1 = compare(classifier1: classifier1, classifier2: classifier2)
        let testResult2 = compare(classifier1: classifier2, classifier2: classifier1)
        let testResultType1 = testResult1.oneTailed(alpha: alpha)
        let testResultType2 = testResult2.oneTailed(alpha: alpha)
        if testResultType1 == StatisticalTestResultType.REJECT{
            return 1
        } else {
            if testResultType2 == StatisticalTestResultType.REJECT {
                return -1
            } else {
                return 0
            }
        }
    }
}
