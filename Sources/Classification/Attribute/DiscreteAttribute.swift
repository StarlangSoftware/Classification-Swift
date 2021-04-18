//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 11.04.2021.
//

import Foundation

public class DiscreteAttribute : Attribute{
    
    public var value: String = "NULL"
    
    /**
     * Constructor for a discrete attribute.
     - Parameters:
        - value: Value of the attribute.
     */
    public init(value: String){
        self.value = value
    }
    
    /**
     * Accessor method for value.
     *
        - Returns: value
     */
    public func getValue() -> String{
        return value
    }
    
    public override func description() -> String{
        if value == ","{
            return "comma"
        }
        return value
    }
    
    public override func continuousAttributeSize() -> Int{
        return 0
    }
    
    public override func continuousAttributes() -> [Double]{
        return []
    }
    
}
