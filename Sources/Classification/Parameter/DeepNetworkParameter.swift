//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class DeepNetworkParameter : LinearPerceptronParameter{
    
    private var hiddenLayers : [Int]
    private var activationFunction : ActivationFunction
    
    /**
     * Parameters of the multi layer perceptron algorithm.
     - Parameters:
        - seed:                 Seed is used for random number generation.
        - learningRate:         Double value for learning rate of the algorithm.
        - etaDecrease:          Double value for decrease in eta of the algorithm.
        - crossValidationRatio: Double value for cross validation ratio of the algorithm.
        - epoch:                Integer value for epoch number of the algorithm.
        - hiddenLayers:          An integer {@link ArrayList} for hidden layers of the algorithm.
        - activationFunction: Activation function
     */
    public init(seed: Int, learningRate: Double, etaDecrease: Double, crossValidationRatio: Double, epoch: Int, hiddenLayers: [Int], activationFunction: ActivationFunction) {
        self.hiddenLayers = hiddenLayers
        self.activationFunction = activationFunction
        super.init(seed: seed, learningRate: learningRate, etaDecrease: etaDecrease, crossValidationRatio: crossValidationRatio, epoch: epoch)
    }
    
    /**
     * The layerSize method returns the size of the hiddenLayers {@link ArrayList}.
     *
        - Returns: The size of the hiddenLayers {@link ArrayList}.
     */
    public func layerSize() -> Int{
        return hiddenLayers.count
    }
    
    /**
     * The getHiddenNodes method takes a layer index as an input and returns the element at the given index of hiddenLayers
     * {@link ArrayList}.
     - Parameters:
        - layerIndex: Index of the layer.
     - Returns: The element at the layerIndex of hiddenLayers {@link ArrayList}.
     */
    public func getHiddenNodes(layerIndex: Int) -> Int{
        return hiddenLayers[layerIndex]
    }

    /**
     * Accessor for the activationFunction.
     *
        - Returns: The activationFunction.
     */
    public func getActivationFunction() -> ActivationFunction{
        return activationFunction
    }

}
