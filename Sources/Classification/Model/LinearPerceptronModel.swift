//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.04.2021.
//

import Foundation
import Math

public class LinearPerceptronModel : NeuralNetworkModel{
    
    public var W: Matrix = Matrix(size: 1)
    
    /**
     * Constructor that sets the {@link NeuralNetworkModel} nodes with given {@link InstanceList}.
     - Parameters:
        - trainSet: InstanceList that is used to train.
     */
    public override init(trainSet: InstanceList) {
        super.init(trainSet: trainSet)
    }
    
    /**
     * Constructor that takes {@link InstanceList}s as trainsSet and validationSet. Initially it allocates layer weights,
     * then creates an input vector by using given trainSet and finds error. Via the validationSet it finds the classification
     * performance and at the end it reassigns the allocated weight Matrix with the matrix that has the best accuracy.
     - Parameters:
        - trainSet:      InstanceList that is used to train.
        - validationSet: InstanceList that is used to validate.
        - parameters:    Linear perceptron parameters; learningRate, etaDecrease, crossValidationRatio, epoch.
     */
    public init(trainSet: InstanceList, validationSet: InstanceList, parameters: LinearPerceptronParameter){
        super.init(trainSet: trainSet)
        W = allocateLayerWeights(row: K, column: d + 1)
        var bestW : Matrix = W.copy() as! Matrix
        var bestClassificationPerformance : ClassificationPerformance = ClassificationPerformance(accuracy: 0.0);
        let epoch = parameters.getEpoch();
        var learningRate : Double = parameters.getLearningRate()
        for _ in 0..<epoch {
            trainSet.shuffle()
            for j in 0..<trainSet.size() {
                createInputVector(instance: trainSet.get(index: j))
                let rMinusY = calculateRMinusY(instance: trainSet.get(index: j), input: x, weights: W)
                let deltaW = rMinusY.multiply(v: x)
                deltaW.multiplyWithConstant(constant: learningRate)
                W.add(m: deltaW)
            }
            let currentClassificationPerformance = testClassifier(data: validationSet)
            if currentClassificationPerformance.getAccuracy() > bestClassificationPerformance.getAccuracy() {
                bestClassificationPerformance = currentClassificationPerformance
                bestW = W.copy() as! Matrix
            }
            learningRate *= parameters.getEtaDecrease()
        }
        W = bestW
    }
    
    /**
     * The calculateOutput method calculates the {@link Matrix} y by multiplying Matrix W with {@link Vector} x.
     */
    public override func calculateOutput() {
        y = W.multiplyWithVectorFromRight(v: x)
    }
}
