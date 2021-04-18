//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.04.2021.
//

import Foundation

public class MultiLayerPerceptron : Classifier{
    
    /**
     * Training algorithm for the multilayer perceptron algorithm. 20 percent of the data is separated as cross-validation
     * data used for selecting the best weights. 80 percent of the data is used for training the multilayer perceptron with
     * gradient descent.
     - Parameters:
        - trainSet:   Training data given to the algorithm
        - parameters: Parameters of the multilayer perceptron.
     */
    public override func train(trainSet: InstanceList, parameters: Parameter) {
        let partition = Partition(instanceList: trainSet, ratio: (parameters as! MultiLayerPerceptronParameter).getCrossValidationRatio(), stratified: true)
        model = MultiLayerPerceptronModel(trainSet: partition.get(index: 1), validationSet: partition.get(index: 0),  parameters: parameters as! MultiLayerPerceptronParameter)
    }
}
