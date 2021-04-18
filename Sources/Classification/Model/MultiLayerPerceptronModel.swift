//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.04.2021.
//

import Foundation
import Math

public class MultiLayerPerceptronModel : LinearPerceptronModel{
    
    private var V: Matrix = Matrix(size: 1)
    
    /**
     * The allocateWeights method allocates layers' weights of Matrix W and V.
     - Parameters:
        - H: Integer value for weights.
     */
    private func allocateWeights(H: Int){
        W = allocateLayerWeights(row: H, column: d + 1)
        V = allocateLayerWeights(row: K, column: H + 1)
    }
    
    /**
     * A constructor that takes {@link InstanceList}s as trainsSet and validationSet. It  sets the {@link NeuralNetworkModel}
     * nodes with given {@link InstanceList} then creates an input vector by using given trainSet and finds error.
     * Via the validationSet it finds the classification performance and reassigns the allocated weight Matrix with the matrix
     * that has the best accuracy and the Matrix V with the best Vector input.
     - Parameters:
        - trainSet:      InstanceList that is used to train.
        - validationSet: InstanceList that is used to validate.
        - parameters:    Multi layer perceptron parameters; seed, learningRate, etaDecrease, crossValidationRatio, epoch, hiddenNodes.
     */
    public init(trainSet: InstanceList, validationSet: InstanceList, parameters: MultiLayerPerceptronParameter){
        super.init(trainSet: trainSet)
        allocateWeights(H: parameters.getHiddenNodes())
        var bestW : Matrix = W.copy() as! Matrix
        var bestV : Matrix = V.copy() as! Matrix
        var bestClassificationPerformance : ClassificationPerformance = ClassificationPerformance(accuracy: 0.0)
        let epoch = parameters.getEpoch()
        var learningRate : Double = parameters.getLearningRate()
        for _ in 0..<epoch {
            trainSet.shuffle()
            for j in 0..<trainSet.size() {
                createInputVector(instance: trainSet.get(index: j))
                let hidden = calculateHidden(input: x, weights: W)
                let hiddenBiased = hidden.biased()
                let rMinusY = calculateRMinusY(instance: trainSet.get(index: j), input: hiddenBiased, weights: V)
                let deltaV = rMinusY.multiply(v: hiddenBiased)
                let oneMinusHidden = calculateOneMinusHidden(hidden: hidden)
                let tmph = V.multiplyWithVectorFromLeft(v: rMinusY)
                tmph.remove(pos: 0);
                let tmpHidden = oneMinusHidden.elementProduct(v: hidden.elementProduct(v: tmph))
                let deltaW = tmpHidden.multiply(v: x)
                deltaV.multiplyWithConstant(constant: learningRate)
                V.add(m: deltaV)
                deltaW.multiplyWithConstant(constant: learningRate)
                W.add(m: deltaW)
            }
            let currentClassificationPerformance = testClassifier(data: validationSet)
            if currentClassificationPerformance.getAccuracy() > bestClassificationPerformance.getAccuracy() {
                bestClassificationPerformance = currentClassificationPerformance;
                bestW = W.copy() as! Matrix
                bestV = V.copy() as! Matrix
            }
            learningRate *= parameters.getEtaDecrease();
        }
        W = bestW;
        V = bestV;
    }
    
    /**
     * The calculateOutput method calculates the forward single hidden layer by using Matrices W and V.
     */
    public override func calculateOutput() {
        calculateForwardSingleHiddenLayer(W: W, V: V)
    }
}
