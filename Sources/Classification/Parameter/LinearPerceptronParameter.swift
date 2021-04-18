//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class LinearPerceptronParameter : Parameter{
    
    public var learningRate : Double
    public var etaDecrease : Double
    public var crossValidationRatio : Double
    private var epoch : Int
    
    /**
     * Parameters of the linear perceptron algorithm.
     - Parameters:
        - seed:                 Seed is used for random number generation.
        - learningRate:         Double value for learning rate of the algorithm.
        - etaDecrease :         Double value for decrease in eta of the algorithm.
        - crossValidationRatio: Double value for cross validation ratio of the algorithm.
        - epoch:                Integer value for epoch number of the algorithm.
     */
    public init(seed: Int, learningRate: Double, etaDecrease: Double, crossValidationRatio: Double, epoch: Int){
        self.learningRate = learningRate
        self.etaDecrease = etaDecrease
        self.crossValidationRatio = crossValidationRatio
        self.epoch = epoch
        super.init(seed: seed)
    }
    
    /**
     * Accessor for the learningRate.
     *
        - Returns: The learningRate.
     */
    public func getLearningRate() -> Double{
        return learningRate
    }
    
    /**
     * Accessor for the etaDecrease.
     *
        - Returns: The etaDecrease.
     */
    public func getEtaDecrease() -> Double{
        return etaDecrease
    }
    
    /**
     * Accessor for the crossValidationRatio.
     *
        - Returns: The crossValidationRatio.
     */
    public func getCrossValidationRatio() -> Double{
        return crossValidationRatio
    }
    
    /**
     * Accessor for the epoch.
     *
        - Returns: The epoch.
     */
    public func getEpoch() -> Int{
        return epoch
    }
}
