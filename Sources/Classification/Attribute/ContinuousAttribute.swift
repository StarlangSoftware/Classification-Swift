//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 11.04.2021.
//

import Foundation

public class ContinuousAttribute : Attribute{
    
    private var value: Double
    
    /**
     * Constructor for a continuous attribute.
     - Parameters:
        - value: Value of the attribute.
     */
    public init(value: Double){
        self.value = value
    }
    
    /**
     * Accessor method for value.
     *
        - Returns: value
     */
    public func getValue() -> Double{
        return value
    }
    
    /**
     * Mutator method for value
     - Parameters:
        - value: New value of value.
     */
    public func setValue(value: Double){
        self.value = value
    }
    
    public override func description() -> String{
        return String(value)
    }
    
    public override func continuousAttributeSize() -> Int {
        return 1
    }
    
    public override func continuousAttributes() -> [Double] {
        var result : [Double] = []
        result.append(value)
        return result
    }
}
