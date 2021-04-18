//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.04.2021.
//

import Foundation

public class LinearPerceptron : Classifier{
    
    /**
     * Training algorithm for the linear perceptron algorithm. 20 percent of the data is separated as cross-validation
     * data used for selecting the best weights. 80 percent of the data is used for training the linear perceptron with
     * gradient descent.
     - Parameters:
        - trainSet:   Training data given to the algorithm
        - parameters: Parameters of the linear perceptron.
     */
    public override func train(trainSet: InstanceList, parameters: Parameter) {
        let partition = Partition(instanceList: trainSet, ratio: (parameters as! LinearPerceptronParameter).getCrossValidationRatio(), stratified: true)
        model = LinearPerceptronModel(trainSet: partition.get(index: 1), validationSet: partition.get(index: 0), parameters: parameters as! LinearPerceptronParameter)
    }
}
