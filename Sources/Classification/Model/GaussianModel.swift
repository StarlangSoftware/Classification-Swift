//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation
import Math

public class GaussianModel : ValidatedModel{
    
    public var priorDistribution : DiscreteDistribution = DiscreteDistribution()
    
    public override init(){
        
    }
    
    /**
     * Abstract method calculateMetric takes an {@link Instance} and a String as inputs.
     - Parameters:
        - instance: {@link Instance} input.
        - Ci:       String input.
     - Returns: A double value as metric.
     */
    public func calculateMetric(instance: Instance, Ci : String) -> Double{
        return 0.0
    }
    
    public override func predict(instance: Instance) -> String {
        var maxMetric : Double = -Double.infinity
        var size : Int
        var predictedClass, Ci : String
        if instance is CompositeInstance {
            predictedClass = (instance as! CompositeInstance).getPossibleClassLabels()[0]
            size = (instance as! CompositeInstance).getPossibleClassLabels().count
        } else {
            predictedClass = priorDistribution.getMaxItem()
            size = priorDistribution.size()
        }
        for i in 0..<size {
            if instance is CompositeInstance {
                Ci = (instance as! CompositeInstance).getPossibleClassLabels()[i]
            } else {
                Ci = priorDistribution.getItem(index: i)
            }
            if priorDistribution.containsItem(item: Ci) {
                let metric = calculateMetric(instance: instance, Ci: Ci);
                if metric > maxMetric {
                    maxMetric = metric
                    predictedClass = Ci
                }
            }
        }
        return predictedClass

    }
}
