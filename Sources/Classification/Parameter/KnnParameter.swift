//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class KnnParameter : KMeansParameter{
    
    private var k : Int
    
    /**
     * Parameters of the K-nearest neighbor classifier.
     - Parameters:
        - seed: Seed is used for random number generation.
        - k: k of the K-nearest neighbor algorithm.
        - distanceMetric: Used to calculate the distance between two instances.
     */
    public init(seed: Int, k: Int, distanceMetric: DistanceMetric){
        self.k = k
        super.init(seed: seed, distanceMetric: distanceMetric)
    }
    
    /**
     * Parameters of the K-nearest neighbor classifier.
     - Parameters:
        - seed:           Seed is used for random number generation.
        - k:              k of the K-nearest neighbor algorithm.
     */
    public init(seed: Int, k: Int){
        self.k = k
        super.init(seed: seed)
    }
    
    /**
     * Accessor for the k.
     *
        - Returns: Value of the k.
     */
    public func getK() -> Int{
        return k
    }
}
