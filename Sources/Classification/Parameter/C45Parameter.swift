//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class C45Parameter : Parameter{
    
    private var prune : Bool
    private var crossValidationRatio : Double
    
    /**
     * Parameters of the C4.5 univariate decision tree classifier.
     - Parameters:
        - seed:                 Seed is used for random number generation.
        - prune:                Boolean value for prune.
        - crossValidationRatio: Double value for cross crossValidationRatio ratio.
     */
    public init(seed: Int, prune : Bool, crossValidationRatio : Double){
        self.prune = prune
        self.crossValidationRatio = crossValidationRatio
        super.init(seed: seed)
    }
    
    /**
     * Accessor for the prune.
     *
        - Returns: Prune.
     */
    public func isPrune() -> Bool{
        return prune
    }
    
    /**
     * Accessor for the crossValidationRatio.
     *
        - Returns: crossValidationRatio.
     */
    public func getCrossValidationRatio() -> Double{
        return crossValidationRatio
    }
}
