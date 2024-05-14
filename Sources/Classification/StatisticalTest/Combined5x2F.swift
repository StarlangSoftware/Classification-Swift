//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation
import Math

public class Combined5x2F : PairedTest{
    
    /// Calculates the test statistic of the combined 5x2 cv F test.
    /// - Parameters:
    ///   - classifier1: Performance (error rate or accuracy) results of the first classifier.
    ///   - classifier2: Performance (error rate or accuracy) results of the second classifier.
    /// - Returns: Given the performances of two classifiers, the test statistic of the combined 5x2 cv F test.
    private func testStatistic(classifier1: ExperimentPerformance, classifier2: ExperimentPerformance) -> Double {
        var difference : [Double] = []
        var numerator : Double = 0.0
        for i in 0..<classifier1.numberOfExperiments() {
            difference[i] = classifier1.getErrorRate(index: i) - classifier2.getErrorRate(index: i)
            numerator += difference[i] * difference[i]
        }
        var denominator : Double = 0.0
        for i in 0..<classifier1.numberOfExperiments() / 2 {
            let mean = (difference[2 * i] + difference[2 * i + 1]) / 2
            let variance = (difference[2 * i] - mean) * (difference[2 * i] - mean) + (difference[2 * i + 1] - mean) * (difference[2 * i + 1] - mean)
            denominator += variance
        }
        denominator *= 2
        return numerator / denominator
    }
    
    /// Compares two classification algorithms based on their performances (accuracy or error rate) using combined 5x2 cv F test.
    /// - Parameters:
    ///   - classifier1: Performance (error rate or accuracy) results of the first classifier.
    ///   - classifier2: Performance (error rate or accuracy) results of the second classifier.
    /// - Returns: Statistical test result of the comparison.
    public override func compare(classifier1: ExperimentPerformance, classifier2: ExperimentPerformance) -> StatisticalTestResult {
        let statistic = testStatistic(classifier1: classifier1, classifier2: classifier2)
        let degreeOfFreedom1 = classifier1.numberOfExperiments()
        let degreeOfFreedom2 = classifier1.numberOfExperiments() / 2
        return StatisticalTestResult(pValue: Distribution.fDistribution(F: statistic, freedom1: degreeOfFreedom1, freedom2: degreeOfFreedom2), onlyTwoTailed: true)
    }

}
