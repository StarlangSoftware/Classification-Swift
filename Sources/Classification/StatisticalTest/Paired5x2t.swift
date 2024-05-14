//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation
import Math

public class Paired5x2t : PairedTest{
    
    /// Calculates the test statistic of the 5x2 t test.
    /// - Parameters:
    ///   - classifier1: Performance (error rate or accuracy) results of the first classifier.
    ///   - classifier2: Performance (error rate or accuracy) results of the second classifier.
    /// - Returns: Given the performances of two classifiers, the test statistic of the 5x2 t test.
    private func testStatistic(classifier1: ExperimentPerformance, classifier2: ExperimentPerformance) -> Double {
        var difference : [Double] = []
        for i in 0..<classifier1.numberOfExperiments() {
            difference.append(classifier1.getErrorRate(index: i) - classifier2.getErrorRate(index: i))
        }
        var denominator : Double = 0.0
        for i in 0..<classifier1.numberOfExperiments() / 2 {
            let mean = (difference[2 * i] + difference[2 * i + 1]) / 2
            let variance = (difference[2 * i] - mean) * (difference[2 * i] - mean) + (difference[2 * i + 1] - mean) * (difference[2 * i + 1] - mean)
            denominator += variance
        }
        denominator = sqrt(denominator / 5)
        return difference[0] / denominator
    }
    
    /// Compares two classification algorithms based on their performances (accuracy or error rate) using 5x2 t test.
    /// - Parameters:
    ///   - classifier1: Performance (error rate or accuracy) results of the first classifier.
    ///   - classifier2: Performance (error rate or accuracy) results of the second classifier.
    /// - Returns: Statistical test result of the comparison.
    public override func compare(classifier1: ExperimentPerformance, classifier2: ExperimentPerformance) -> StatisticalTestResult {
        let statistic = testStatistic(classifier1: classifier1, classifier2: classifier2)
        let degreeOfFreedom = classifier1.numberOfExperiments() / 2
        return StatisticalTestResult(pValue: Distribution.tDistribution(T: statistic, freedom: degreeOfFreedom), onlyTwoTailed: false)
    }

}
