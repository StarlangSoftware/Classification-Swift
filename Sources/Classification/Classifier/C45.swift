//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation

public class C45 : Classifier{
    
    /**
     * Training algorithm for C4.5 univariate decision tree classifier. 20 percent of the data are left aside for pruning
     * 80 percent of the data is used for constructing the tree.
     - Parameters:
        - trainSet:   Training data given to the algorithm.
        - parameters: -
     */
    public override func train(trainSet: InstanceList, parameters: Parameter) {
        var tree : DecisionTree
        if (parameters as! C45Parameter).isPrune() {
            let partition = Partition(instanceList: trainSet, ratio: (parameters as! C45Parameter).getCrossValidationRatio(), stratified: true);
            tree = DecisionTree(root: DecisionNode(data: partition.get(index: 1), condition: nil, parameter: nil, isStump: false))
            tree.prune(pruneSet: partition.get(index: 0))
        } else {
            tree = DecisionTree(root: DecisionNode(data: trainSet, condition: nil, parameter: nil, isStump: false))
        }
        model = tree
    }
}
