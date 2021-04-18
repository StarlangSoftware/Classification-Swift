//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation

public class Dummy : Classifier{
    
    /**
     * Training algorithm for the dummy classifier. Actually dummy classifier returns the maximum occurring class in
     * the training data, there is no training.
     - Parameters:
        - trainSet:   Training data given to the algorithm.
        - parameters: -
     */
    public override func train(trainSet: InstanceList, parameters: Parameter) {
        model = DummyModel(trainSet: trainSet)
    }
}
