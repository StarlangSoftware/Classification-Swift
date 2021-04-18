//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class RandomForestParameter : BaggingParameter{
    
    private var attributeSubsetSize : Int
    
    /**
     * Parameters of the random forest classifier.
     - Parameters:
        - seed:                Seed is used for random number generation.
        - ensembleSize:        The number of trees in the bagged forest.
        - attributeSubsetSize: Integer value for the size of attribute subset.
     */
    public init(seed: Int, ensembleSize: Int, attributeSubsetSize: Int){
        self.attributeSubsetSize = attributeSubsetSize
        super.init(seed: seed, ensembleSize: ensembleSize)
    }
    
    /**
     * Accessor for the attributeSubsetSize.
     *
        - Returns: The attributeSubsetSize.
     */
    public func getAttributeSubsetSize() -> Int{
        return attributeSubsetSize
    }
}
