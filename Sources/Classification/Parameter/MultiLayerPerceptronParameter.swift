//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class MultiLayerPerceptronParameter : LinearPerceptronParameter{
    
    private var hiddenNodes : Int
    
    /**
     * Parameters of the multi layer perceptron algorithm.
     - Parameters:
        - seed:                 Seed is used for random number generation.
        - learningRate:         Double value for learning rate of the algorithm.
        - etaDecrease:          Double value for decrease in eta of the algorithm.
        - crossValidationRatio: Double value for cross validation ratio of the algorithm.
        - epoch:                Integer value for epoch number of the algorithm.
        - hiddenNodes:          Integer value for the number of hidden nodes.
     */
    public init(seed: Int, learningRate: Double, etaDecrease: Double, crossValidationRatio: Double, epoch: Int, hiddenNodes: Int) {
        self.hiddenNodes = hiddenNodes
        super.init(seed: seed, learningRate: learningRate, etaDecrease: etaDecrease, crossValidationRatio: crossValidationRatio, epoch: epoch)
    }
    
    /**
     * Accessor for the hiddenNodes.
     *
        - Returns: The hiddenNodes.
     */
    public func getHiddenNodes() -> Int{
        return hiddenNodes
    }
}
