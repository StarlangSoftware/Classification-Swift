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
    
    /// Compares two classification algorithms based on their performances (accuracy or error rate). The method first
    /// checks the null hypothesis mu1  is less than mu2, if the test rejects this null hypothesis with alpha level of confidence, it
    /// decides mu1 > mu2. The algorithm then checks the null hypothesis mu1 > mu2, if the test rejects that null
    /// hypothesis with alpha level of confidence, if decides mu1 is less than mu2. If none of the two tests are rejected, it can not
    /// make a decision about the performances of algorithms.
    /// - Parameters:
    ///   - classifier1: Performance (error rate or accuracy) results of the first classifier.
    ///   - classifier2: Performance (error rate or accuracy) results of the second classifier.
    ///   - alpha: Alpha level defined for the statistical test.
    /// - Returns: 1 if the performance of the first algorithm is larger than the second algorithm, -1 if the performance of
    /// the second algorithm is larger than the first algorithm, 0 if they have similar performance.
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
