//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 18.04.2021.
//

import Foundation

public class FloatingSelection : SubSetSelection{
    
    /**
     * Constructor that creates a new {@link FeatureSubSet}.
     */
    public init() {
        super.init(initialSubSet: FeatureSubSet())
    }
    
    /**
     * The operator method calls forward and backward methods.
     - Parameters:
        - current:          {@link FeatureSubSet} input.
        - numberOfFeatures: Indicates the indices of indexList.
     - Returns: ArrayList of FeatureSubSet.
     */
    public override func selectionOperator(current: FeatureSubSet, numberOfFeatures: Int) -> [FeatureSubSet] {
        var result : [FeatureSubSet] = []
        forward(currentSubSetList: &result, current: current, numberOfFeatures: numberOfFeatures)
        backward(currentSubSetList: &result, current: current)
        return result
    }
}
