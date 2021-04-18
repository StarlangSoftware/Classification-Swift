//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.04.2021.
//

import Foundation

public class Bagging : Classifier{
    
    /**
     * Bagging bootstrap ensemble method that creates individuals for its ensemble by training each classifier on a random
     * redistribution of the training set.
     * This training method is for a bagged decision tree classifier. 20 percent of the instances are left aside for pruning of the trees
     * 80 percent of the instances are used for training the trees. The number of trees (forestSize) is a parameter, and basically
     * the method will learn an ensemble of trees as a model.
      - Parameters
        - trainSet:   Training data given to the algorithm.
        - parameters: Parameters of the bagging trees algorithm. ensembleSize returns the number of trees in the bagged forest.
     */
    public override func train(trainSet: InstanceList, parameters: Parameter) {
        let forestSize = (parameters as! BaggingParameter).getEnsembleSize()
        var forest : [DecisionTree] = []
        for i in 0..<forestSize {
            let bootstrap = trainSet.bootstrap(seed: i)
            let tree = DecisionTree(root: DecisionNode( data: InstanceList(list: bootstrap.getSample()), condition: nil, parameter: nil, isStump: false))
            forest.append(tree)
        }
        model = TreeEnsembleModel(forest: forest)
    }
}
