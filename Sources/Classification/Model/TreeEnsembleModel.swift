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
     * A constructor which sets the {@link ArrayList} of {@link DecisionTree} with given input.
     - Parameters:
        - forest: An {@link ArrayList} of {@link DecisionTree}.
     */
    public init(forest: [DecisionTree]){
        self.forest = forest
    }
    
    public override func predict(instance: Instance) -> String {
        let distribution = DiscreteDistribution()
        for tree in forest {
            distribution.addItem(item: tree.predict(instance: instance))
        }
        return distribution.getMaxItem()
    }
}
