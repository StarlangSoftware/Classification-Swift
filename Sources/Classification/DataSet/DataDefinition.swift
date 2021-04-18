//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 11.04.2021.
//

import Foundation

public class DataDefinition {
    
    private var attributeTypes : [AttributeType]
    
    /**
     * Constructor for creating a new {@link DataDefinition}.
     */
    public init(){
        attributeTypes = []
    }
    
    /**
     * Constructor for creating a new {@link DataDefinition} with given attribute types.
     - Parameters:
        - attributeTypes: Attribute types of the data definition.
     */
    public init(attributeTypes: [AttributeType]){
        self.attributeTypes = attributeTypes
    }
    
    /**
     * Returns the number of attribute types.
     *
        - Returns: Number of attribute types.
     */
    public func attributeCount() -> Int{
        return attributeTypes.count
    }
    
    /**
     * Counts the occurrences of binary and discrete type attributes.
     *
        - Returns: Count of binary and discrete type attributes.
     */
    public func discreteAttributeCount() -> Int{
        var count : Int = 0
        for attributeType in attributeTypes {
            if attributeType == AttributeType.DISCRETE || attributeType == AttributeType.BINARY {
                count += 1
            }
        }
        return count
    }
    
    /**
     * Counts the occurrences of binary and continuous type attributes.
     *
        - Returns: Count of of binary and continuous type attributes.
     */
    public func continuousAttributeCount() -> Int{
        var count : Int = 0
        for attributeType in attributeTypes {
            if attributeType == AttributeType.CONTINUOUS {
                count += 1
            }
        }
        return count
    }
    
    /**
     * Returns the attribute type of the corresponding item at given index.
     - Parameters:
        - index: Index of the attribute type.
     - Returns: Attribute type of the corresponding item at given index.
     */
    public func getAttributeType(index: Int) -> AttributeType{
        return attributeTypes[index]
    }
    
    /**
     * Adds an attribute type to the list of attribute types.
     - Parameters:
        - attributeType: Attribute type to add to the list of attribute types.
     */
    public func addAttribute(attributeType: AttributeType){
        attributeTypes.append(attributeType)
    }
    
    /**
     * Removes the attribute type at given index from the list of attributes.
     - Parameters:
        - index: Index to remove attribute type from list.
     */
    public func removeAttribute(index: Int){
        attributeTypes.remove(at: index)
    }
    
    /**
     * Clears all the attribute types from list.
     */
    public func removeAllAttributes() {
        attributeTypes.removeAll()
    }
    
}
