//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.04.2021.
//

import Foundation
import Math

public class TreeEnsembleModel : Model {
    
    private var forest : [DecisionTree]
    
    /**
     * A constructor which sets the ArrayList of DecisionTree with given input.
     - Parameters:
        - forest: An ArrayList of DecisionTree.
     */
    public init(forest: [DecisionTree]){
        self.forest = forest
    }
    
    /// The predict method takes an Instance as an input and loops through the ArrayList of DecisionTrees.
    /// Makes prediction for the items of that ArrayList and returns the maximum item of that ArrayList.
    /// - Parameter instance: Instance to make prediction.
    /// - Returns: The maximum prediction of a given Instance.
    public override func predict(instance: Instance) -> String {
        let distribution = DiscreteDistribution()
        for tree in forest {
            distribution.addItem(item: tree.predict(instance: instance))
        }
        return distribution.getMaxItem()
    }
    
    /// Calculates the posterior probability distribution for the given instance according to ensemble tree model.
    /// - Parameter instance: Instance for which posterior probability distribution is calculated.
    /// - Returns: Posterior probability distribution for the given instance.
    public override func predictProbability(instance: Instance) -> [String : Double] {
        let distribution = DiscreteDistribution()
        for tree in forest {
            distribution.addItem(item: tree.predict(instance: instance))
        }
        return distribution.getProbabilityDistribution()
    }
}
