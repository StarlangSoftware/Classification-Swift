//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class Sign : PairedTest{
    
    private func factorial(n: Int) -> Int{
        var result : Int = 1
        for i in 2...n{
            result *= i
        }
        return result
    }
    
    private func binomial(m: Int, n: Int) -> Int{
        if n == 0 || m == n{
            return 1
        } else {
            return factorial(n: m) / (factorial(n: n) * factorial(n: m - n))
        }
    }
    
    public override func compare(classifier1: ExperimentPerformance, classifier2: ExperimentPerformance) -> StatisticalTestResult {
        var plus : Int = 0
        var minus : Int = 0
        for i in 0..<classifier1.numberOfExperiments() {
            if classifier1.getErrorRate(index: i) < classifier2.getErrorRate(index: i) {
                plus += 1
            } else {
                if classifier1.getErrorRate(index: i) > classifier2.getErrorRate(index: i) {
                    minus += 1
                }
            }
        }
        let total = plus + minus
        var pValue : Double = 0.0
        for i in 0...plus {
            pValue += Double(binomial(m: total, n: i)) / Double(truncating: pow(1, total) as NSNumber)
        }
        return StatisticalTestResult(pValue: pValue, onlyTwoTailed: false)
    }
}
