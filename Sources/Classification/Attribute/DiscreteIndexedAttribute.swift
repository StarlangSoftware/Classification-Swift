//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 11.04.2021.
//

import Foundation

public class DiscreteIndexedAttribute : DiscreteAttribute{
    
    private var index: Int
    private var maxIndex: Int
    
    /**
     * Constructor for a discrete attribute.
     - Parameters:
        - value: Value of the attribute.
        - index: Index of the attribute.
        - maxIndex: Maximum index of the attribute.
     */
    public init(value: String, index: Int, maxIndex: Int){
        self.index = index
        self.maxIndex = maxIndex
        super.init(value: value)
    }
    
    /**
     * Accessor method for index.
     *
        - Returns: index.
     */
    public func getIndex() -> Int{
        return index
    }
    
    /**
     * Accessor method for maxIndex.
     *
        - Returns: maxIndex.
     */
    public func getMaxIndex() -> Int{
        return maxIndex
    }
    
    public override func continuousAttributeSize() -> Int {
        return maxIndex
    }
    
    public override func continuousAttributes() -> [Double] {
        var result : [Double] = []
        for i in 0..<maxIndex {
            if i != index {
                result.append(0.0)
            } else {
                result.append(1.0)
            }
        }
        return result
    }
}
