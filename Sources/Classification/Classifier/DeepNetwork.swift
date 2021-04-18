//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.04.2021.
//

import Foundation

public class DeepNetwork : Classifier{
    
    /**
     * Training algorithm for deep network classifier.
     - Parameters:
        - trainSet:   Training data given to the algorithm.
        - parameters: Parameters of the deep network algorithm. crossValidationRatio and seed are used as parameters.
     */
    public override func train(trainSet: InstanceList, parameters: Parameter) {
        let partition = Partition(instanceList: trainSet, ratio: (parameters as! DeepNetworkParameter).getCrossValidationRatio(), stratified: true)
        model = DeepNetworkModel(trainSet: partition.get(index: 1), validationSet: partition.get(index: 0), parameters: parameters as! DeepNetworkParameter)
    }
}
