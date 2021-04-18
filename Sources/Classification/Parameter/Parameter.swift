//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class Parameter{
    
    private var seed : Int
    
    /**
     * Constructor of {@link Parameter} class which assigns given seed value to seed.
     - Parameters:
        - seed: Seed is used for random number generation.
     */
    public init(seed: Int){
        self.seed = seed
    }
    
    /**
     * Accessor for the seed.
     *
        - Returns: The seed.
     */
    public func getSeed() -> Int{
        return seed
    }
}
