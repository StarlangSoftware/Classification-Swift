//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation
import Math

public class RandomClassifier : Classifier{
    
    /**
     * Training algorithm for random classifier.
     - Parameters:
        - trainSet:   Training data given to the algorithm.
        - parameters: -
     */
    public override func train(trainSet: InstanceList, parameters: Parameter) {
        model = RandomModel(classLabels: trainSet.classDistribution().keySet(), seed: parameters.getSeed())
    }
}
