//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class BaggingParameter : Parameter {
    
    public var ensembleSize : Int
    
    /**
     * Parameters of the bagging trees algorithm.
     - Parameters:
        - seed:         Seed is used for random number generation.
        - ensembleSize: The number of trees in the bagged forest.
     */
    public init(seed: Int, ensembleSize: Int){
        self.ensembleSize = ensembleSize
        super.init(seed: seed)
    }
    
    /**
     * Accessor for the ensemble size.
     *
        - Returns: The ensemble size.
     */
    public func getEnsembleSize() -> Int{
        return ensembleSize
    }
}
