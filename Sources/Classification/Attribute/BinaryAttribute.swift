//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 11.04.2021.
//

import Foundation

public class BinaryAttribute : DiscreteAttribute{
    
    /**
     * Constructor for a binary discrete attribute. The attribute can take only two values "True" or "False".
     - Parameters:
        - value: Value of the attribute. Can be true or false.
     */
    public init(value: Bool){
        super.init(value: value.description)
    }
}
