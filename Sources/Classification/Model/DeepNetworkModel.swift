//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.04.2021.
//

import Foundation
import Math
import Util

public class DeepNetworkModel : NeuralNetworkModel{
    
    private var weights: [Matrix] = []
    private var hiddenLayerSize: Int = 0
    private var activationFunction: ActivationFunction
    
    /**
     * The allocateWeights method takes {@link DeepNetworkParameter}s as an input. First it adds random weights to the {@link ArrayList}
     * of {@link Matrix} weights' first layer. Then it loops through the layers and adds random weights till the last layer.
     * At the end it adds random weights to the last layer and also sets the hiddenLayerSize value.
     - Parameters:
        - parameters: {@link DeepNetworkParameter} input.
     */
    private func allocateWeights(parameters: DeepNetworkParameter){
        weights = []
        weights.append(allocateLayerWeights(row: parameters.getHiddenNodes(layerIndex: 0), column: d + 1, random: Random(seed: parameters.getSeed())))
        for i in 0..<parameters.layerSize() - 1 {
            weights.append(allocateLayerWeights(row: parameters.getHiddenNodes(layerIndex: i + 1), column: parameters.getHiddenNodes(layerIndex: i) + 1, random: Random(seed: parameters.getSeed())))
        }
        weights.append(allocateLayerWeights(row: K, column: parameters.getHiddenNodes(layerIndex: parameters.layerSize() - 1) + 1, random: Random(seed: parameters.getSeed())))
        hiddenLayerSize = parameters.layerSize()
    }
    
    /**
     * The setBestWeights method creates an {@link ArrayList} of Matrix as bestWeights and clones the values of weights {@link ArrayList}
     * into this newly created {@link ArrayList}.
     *
        - Returns: An {@link ArrayList} clones from the weights ArrayList.
     */
    private func setBestWeights() -> [Matrix]{
        var bestWeights : [Matrix] = []
        for m in weights {
            bestWeights.append(m.copy() as! Matrix)
        }
        return bestWeights
    }
    
    /**
     * Constructor that takes two {@link InstanceList} train set and validation set and {@link DeepNetworkParameter} as inputs.
     * First it sets the class labels, their sizes as K and the size of the continuous attributes as d of given train set and
     * allocates weights and sets the best weights. At each epoch, it shuffles the train set and loops through the each item of that train set,
     * it multiplies the weights Matrix with input Vector than applies the sigmoid function and stores the result as hidden and add bias.
     * Then updates weights and at the end it compares the performance of these weights with validation set. It updates the bestClassificationPerformance and
     * bestWeights according to the current situation. At the end it updates the learning rate via etaDecrease value and finishes
     * with clearing the weights.
     - Parameters:
        - trainSet:      {@link InstanceList} to be used as trainSet.
        - validationSet: {@link InstanceList} to be used as validationSet.
        - parameters:    {@link DeepNetworkParameter} input.
     */
    public init(trainSet: InstanceList, validationSet: InstanceList, parameters: DeepNetworkParameter){
        activationFunction = parameters.getActivationFunction()
        super.init(trainSet: trainSet)
        var deltaWeights : [Matrix] = []
        var hidden : [Vector] = []
        var tmph, oneMinusHidden, activationDerivative, tmpHidden: Vector
        var hiddenBiased : [Vector] = []
        allocateWeights(parameters: parameters)
        var bestWeights : [Matrix] = setBestWeights()
        var bestClassificationPerformance : ClassificationPerformance = ClassificationPerformance(accuracy: 0.0)
        let epoch = parameters.getEpoch()
        var learningRate : Double = parameters.getLearningRate()
        var k: Int
        tmpHidden = Vector(size: 0, x: 0.0)
        for _ in 0..<epoch {
            trainSet.shuffle()
            for j in 0..<trainSet.size() {
                createInputVector(instance: trainSet.get(index: j))
                hidden.removeAll()
                hiddenBiased.removeAll()
                deltaWeights.removeAll()
                for k in 0..<hiddenLayerSize {
                    if k == 0 {
                        hidden.append(calculateHidden(input: x, weights: weights[k], activationFunction: activationFunction))
                    } else {
                        hidden.append(calculateHidden(input: hiddenBiased[k - 1], weights: weights[k], activationFunction: activationFunction))
                    }
                    hiddenBiased.append(hidden[k].biased())
                }
                let rMinusY = calculateRMinusY(instance: trainSet.get(index: j), input: hiddenBiased[hiddenLayerSize - 1], weights: weights[weights.count - 1])
                deltaWeights.insert(rMinusY.multiply(v: hiddenBiased[hiddenLayerSize - 1]), at: 0)
                k = weights.count - 2
                while k >= 0 {
                    if k == weights.count - 2{
                        tmph = weights[k + 1].multiplyWithVectorFromLeft(v: rMinusY)
                    } else {
                        tmph = weights[k + 1].multiplyWithVectorFromLeft(v: tmpHidden)
                    }
                    tmph.remove(pos: 0)
                    switch activationFunction {
                        case .SIGMOID:
                            oneMinusHidden = calculateOneMinusHidden(hidden: hidden[k])
                            activationDerivative = oneMinusHidden.elementProduct(v: hidden[k])
                        case .TANH:
                            let one = Vector(size: hidden.count, x: 1.0)
                            hidden[k].tanh();
                            activationDerivative = one.difference(v: hidden[k].elementProduct(v: hidden[k]))
                        case .RELU:
                            hidden[k].reluDerivative()
                            activationDerivative = hidden[k]
                    }
                    tmpHidden = tmph.elementProduct(v: activationDerivative)
                    if k == 0 {
                        deltaWeights.insert(tmpHidden.multiply(v: x), at: 0)
                    } else {
                        deltaWeights.insert(tmpHidden.multiply(v: hiddenBiased[k - 1]), at: 0)
                    }
                    k -= 1
                }
                for k in 0..<weights.count {
                    deltaWeights[k].multiplyWithConstant(constant: learningRate)
                    weights[k].add(m: deltaWeights[k])
                }
            }
            let currentClassificationPerformance = testClassifier(data: validationSet)
            if currentClassificationPerformance.getAccuracy() > bestClassificationPerformance.getAccuracy() {
                bestClassificationPerformance = currentClassificationPerformance
                bestWeights = setBestWeights()
            }
            learningRate *= parameters.getEtaDecrease()
        }
        weights.removeAll()
        for m in bestWeights {
            weights.append(m)
        }
    }
    
    /**
     * The calculateOutput method loops size of the weights times and calculate one hidden layer at a time and adds bias term.
     * At the end it updates the output y value.
     */
    public override func calculateOutput() {
        var hidden : Vector
        var hiddenBiased : Vector? = nil
        for i in 0..<weights.count - 1 {
            if i == 0 {
                hidden = calculateHidden(input: x, weights: weights[i], activationFunction: activationFunction)
            } else {
                hidden = calculateHidden(input: hiddenBiased!, weights: weights[i], activationFunction: activationFunction)
            }
            hiddenBiased = hidden.biased()
        }
        y = weights[weights.count - 1].multiplyWithVectorFromRight(v: hiddenBiased!)
    }
}
