//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation
import Math

public class Pairedt : PairedTest{
    
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
    
    public override func compare(classifier1: ExperimentPerformance, classifier2: ExperimentPerformance) -> StatisticalTestResult {
        let statistic = testStatistic(classifier1: classifier1, classifier2: classifier2)
        let degreeOfFreedom = classifier1.numberOfExperiments() - 1
        return StatisticalTestResult(pValue: Distribution.tDistribution(T: statistic, freedom: degreeOfFreedom), onlyTwoTailed: false)
    }

}
