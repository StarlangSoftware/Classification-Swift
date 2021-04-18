//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class EuclidianDistance : DistanceMetric{
    
    public func EuclidianDistance() {
        
    }
    
    /**
     * Calculates Euclidian distance between two instances. For continuous features: \sum_{i=1}^d (x_i^(1) - x_i^(2))^2,
     * For discrete features: \sum_{i=1}^d 1(x_i^(1) == x_i^(2))
     - Parameters:
        - instance1: First instance
        - instance2: Second instance
     - Returns: Euclidian distance between two instances.
     */
    public func distance(instance1: Instance, instance2: Instance) -> Double {
        var result : Double = 0.0
        for i in 0..<instance1.attributeSize() {
            if instance1.getAttribute(index: i) is DiscreteAttribute && instance2.getAttribute(index: i) is DiscreteAttribute {
                if (instance1.getAttribute(index: i) as! DiscreteAttribute).getValue() != (instance2.getAttribute(index: i) as! DiscreteAttribute).getValue() {
                    result += 1
                }
            } else {
                if instance1.getAttribute(index: i) is ContinuousAttribute && instance2.getAttribute(index: i) is ContinuousAttribute {
                    result += pow((instance1.getAttribute(index: i) as! ContinuousAttribute).getValue() - ( instance2.getAttribute(index: i) as! ContinuousAttribute).getValue(), 2)
                }
            }
        }
        return result
    }
}
