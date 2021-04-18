//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation

public class C45Stump : Classifier{
    
    /**
     * Training algorithm for C4.5 Stump univariate decision tree classifier.
     - Parameters:
        - trainSet:   Training data given to the algorithm.
        - parameters: -
     */
    public override func train(trainSet: InstanceList, parameters: Parameter) {
        model = DecisionTree(root: DecisionNode(data: trainSet, condition: nil, parameter: nil, isStump: true))
    }
}
