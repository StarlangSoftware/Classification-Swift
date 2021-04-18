//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class KMeansParameter : Parameter{
    
    public var distanceMetric : DistanceMetric
    
    /**
     * Parameters of the K Means classifier.
     - Parameters:
        - seed: Seed is used for random number generation.
     */
    public override init(seed : Int){
        distanceMetric = EuclidianDistance()
        super.init(seed: seed)
    }
    
    /**
     * Parameters of the K Means classifier.
     - Parameters:
        - seed :          Seed is used for random number generation.
        - distanceMetric: distance metric used to calculate the distance between two instances.
     */
    public init(seed: Int, distanceMetric: DistanceMetric){
        self.distanceMetric = distanceMetric
        super.init(seed: seed)
    }
    
    /**
     * Accessor for the distanceMetric.
     *
        - Returns: The distanceMetric.
     */
    public func getDistanceMetric() -> DistanceMetric{
        return distanceMetric
    }
}
