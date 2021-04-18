//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation
import Math

public class KMeansModel : GaussianModel{
    
    private var classMeans: InstanceList
    private var distanceMetric: DistanceMetric
    
    /**
     * The constructor that sets the classMeans, priorDistribution and distanceMetric according to given inputs.
     - Parameters:
        - priorDistribution: {@link DiscreteDistribution} input.
        - classMeans:        {@link InstanceList} of class means.
        - distanceMetric:    {@link DistanceMetric} input.
     */
    public init(priorDistribution: DiscreteDistribution, classMeans: InstanceList, distanceMetric: DistanceMetric) {
        self.classMeans = classMeans
        self.distanceMetric = distanceMetric
        super.init()
        self.priorDistribution = priorDistribution
    }
    
    /**
     * The calculateMetric method takes an {@link Instance} and a String as inputs. It loops through the class means, if
     * the corresponding class label is same as the given String it returns the negated distance between given instance and the
     * current item of class means. Otherwise it returns the smallest negative number.
     - Parameters:
        - instance: {@link Instance} input.
        - Ci :      String input.
     - Returns: The negated distance between given instance and the current item of class means.
     */
    public override func calculateMetric(instance: Instance, Ci: String) -> Double {
        for i in 0..<classMeans.size() {
            if classMeans.get(index: i).getClassLabel() == Ci {
                return -distanceMetric.distance(instance1: instance, instance2: classMeans.get(index: i))
            }
        }
        return -Double.infinity
    }
}
