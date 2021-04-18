//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 18.04.2021.
//

import Foundation

public class ForwardSelection : SubSetSelection{
    
    /**
     * Constructor that creates a new {@link FeatureSubSet}.
     */
    public init(){
        super.init(initialSubSet: FeatureSubSet())
    }
    
    /**
     * The operator method calls forward method which starts with having no feature in the model. In each iteration,
     * it keeps adding the features that are not currently listed.
     - Parameters:
        - current:          FeatureSubset that will be added to new ArrayList.
        - numberOfFeatures: Indicates the indices of indexList.
     - Returns: ArrayList of FeatureSubSets created from forward.
     */
    public override func selectionOperator(current: FeatureSubSet, numberOfFeatures: Int) -> [FeatureSubSet] {
        var result : [FeatureSubSet] = []
        forward(currentSubSetList: &result, current: current, numberOfFeatures: numberOfFeatures)
        return result
    }
}
