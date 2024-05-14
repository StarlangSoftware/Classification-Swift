//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation
import Math

public class Pairedt : PairedTest{
    
    /// Calculates the test statistic of the paired t test.
    /// - Parameters:
    ///   - classifier1: Performance (error rate or accuracy) results of the first classifier.
    ///   - classifier2: Performance (error rate or accuracy) results of the second classifier.
    /// - Returns: Given the performances of two classifiers, the test statistic of the paired t test.
    private func testStatistic(classifier1: ExperimentPerformance, classifier2: ExperimentPerformance) -> Double {
        var difference : [Double] = []
        var sum : Double = 0.0
        for i in 0..<classifier1.numberOfExperiments() {
            difference.append(classifier1.getErrorRate(index: i) - classifier2.getErrorRate(index: i))
            sum += difference[i]
        }
        let mean = sum / Double(classifier1.numberOfExperiments())
        sum = 0.0
        for i in 0..<classifier1.numberOfExperiments() {
            sum += (difference[i] - mean) * (difference[i] - mean)
        }
        let standardDeviation = sqrt(sum / Double((classifier1.numberOfExperiments() - 1)))
        return sqrt(Double(classifier1.numberOfExperiments())) * mean / standardDeviation
    }
    
    /// Compares two classification algorithms based on their performances (accuracy or error rate) using paired t test.
    /// - Parameters:
    ///   - classifier1: Performance (error rate or accuracy) results of the first classifier.
    ///   - classifier2: Performance (error rate or accuracy) results of the second classifier.
    /// - Returns: Statistical test result of the comparison.
    public override func compare(classifier1: ExperimentPerformance, classifier2: ExperimentPerformance) -> StatisticalTestResult {
        let statistic = testStatistic(classifier1: classifier1, classifier2: classifier2)
        let degreeOfFreedom = classifier1.numberOfExperiments() - 1
        return StatisticalTestResult(pValue: Distribution.tDistribution(T: statistic, freedom: degreeOfFreedom), onlyTwoTailed: false)
    }

}
