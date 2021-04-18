//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation
import Math

public class MahalanobisDistance : DistanceMetric{
    
    private var covarianceInverse : Matrix
    
    /**
     * Constructor for the MahalanobisDistance class. Basically sets the inverse of the covariance matrix.
     - Parameters:
        - covarianceInverse: Inverse of the covariance matrix.
     */
    public init(covarianceInverse: Matrix){
        self.covarianceInverse = covarianceInverse
    }
    
    /**
     * Calculates Mahalanobis distance between two instances. (x^(1) - x^(2)) S (x^(1) - x^(2))^T
     - Parameters:
        - instance1: First instance.
        - instance2: Second instance.
     - Returns: Mahalanobis distance between two instances.
     */
    public func distance(instance1: Instance, instance2: Instance) -> Double {
        let v1 = instance1.toVector()
        let v2 = instance2.toVector()
        v1.subtract(v: v2)
        let v3 = covarianceInverse.multiplyWithVectorFromLeft(v: v1)
        return v3.dotProduct(v: v1)
    }

}
