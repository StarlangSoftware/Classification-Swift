//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 18.04.2021.
//

import Foundation

public class BackwardSelection : SubSetSelection{
    
    /**
     * Constructor that creates a new {@link FeatureSubSet} and initializes indexList with given number of features.
     - Parameters:
        - numberOfFeatures: Indicates the indices of indexList.
     */
    public init(numberOfFeatures: Int){
        super.init(initialSubSet: FeatureSubSet(numberOfFeatures: numberOfFeatures))
    }
    
    /**
     * The operator method calls backward method which starts with all the features and removes the least significant feature at each iteration.
     - Parameters:
        - current :         FeatureSubset that will be added to new ArrayList.
        - numberOfFeatures: Indicates the indices of indexList.
     - Returns: ArrayList of FeatureSubSets created from backward.
     */
    public override func selectionOperator(current: FeatureSubSet, numberOfFeatures: Int) -> [FeatureSubSet] {
        var result : [FeatureSubSet] = []
        backward(currentSubSetList: &result, current: current)
        return result
    }
}
