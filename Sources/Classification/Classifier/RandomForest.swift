//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.04.2021.
//

import Foundation

public class RandomForest : Classifier{
    
    /**
     * Training algorithm for random forest classifier. Basically the algorithm creates K distinct decision trees from
     * K bootstrap samples of the original training set.
     - Parameters:
        - trainSet:   Training data given to the algorithm
        - parameters: Parameters of the bagging trees algorithm. ensembleSize returns the number of trees in the random forest.
     */
    public override func train(trainSet: InstanceList, parameters: Parameter) {
        let forestSize = (parameters as! RandomForestParameter).getEnsembleSize();
        var forest : [DecisionTree] = []
        for i in 0..<forestSize {
            let bootstrap = trainSet.bootstrap(seed: i)
            let tree = DecisionTree(root: DecisionNode( data: InstanceList(list: bootstrap.getSample()), condition: nil, parameter: (parameters as! RandomForestParameter), isStump: false))
            forest.append(tree)
        }
        model = TreeEnsembleModel(forest: forest)
    }
}
