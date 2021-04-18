//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation

public class DecisionCondition {
    
    private var attributeIndex : Int = -1
    private var comparison : Character
    private var value : Attribute
    
    /**
     * A constructor that sets attributeIndex and {@link Attribute} value. It also assigns equal sign to the comparison character.
     - Parameters:
        - attributeIndex: Integer number that shows attribute index.
        - value:          The value of the {@link Attribute}.
     */
    public init(attributeIndex: Int, value: Attribute){
        self.attributeIndex = attributeIndex
        comparison = "="
        self.value = value
    }
    
    /**
     * A constructor that sets attributeIndex, comparison and {@link Attribute} value.
     - Parameters:
        - attributeIndex: Integer number that shows attribute index.
        - value :         The value of the {@link Attribute}.
        - comparison:     Comparison character.
     */
    public init(attributeIndex: Int, comparison: Character, value: Attribute){
        self.attributeIndex = attributeIndex
        self.comparison = comparison
        self.value = value
    }
    
    /**
     * The satisfy method takes an {@link Instance} as an input.
     * <p>
     * If defined {@link Attribute} value is a {@link DiscreteIndexedAttribute} it compares the index of {@link Attribute} of instance at the
     * attributeIndex and the index of {@link Attribute} value and returns the result.
     * <p>
     * If defined {@link Attribute} value is a {@link DiscreteAttribute} it compares the value of {@link Attribute} of instance at the
     * attributeIndex and the value of {@link Attribute} value and returns the result.
     * <p>
     * If defined {@link Attribute} value is a {@link ContinuousAttribute} it compares the value of {@link Attribute} of instance at the
     * attributeIndex and the value of {@link Attribute} value and returns the result according to the comparison character whether it is
     * less than or greater than signs.
     - Parameters:
        - instance: Instance to compare.
     - Returns: True if gicen instance satisfies the conditions.
     */
    public func satisfy(instance: Instance) -> Bool{
        if value is DiscreteIndexedAttribute {
            if (value as! DiscreteIndexedAttribute).getIndex() != -1 {
                return (instance.getAttribute(index: attributeIndex) as! DiscreteIndexedAttribute).getIndex() == (value as! DiscreteIndexedAttribute).getIndex()
            } else {
                return true
            }
        } else {
            if value is DiscreteAttribute {
                return (instance.getAttribute(index: attributeIndex) as! DiscreteAttribute).getValue() == (value as! DiscreteAttribute).getValue()
            } else {
                if value is ContinuousAttribute {
                    if comparison == "<" {
                        return (instance.getAttribute(index: attributeIndex) as! ContinuousAttribute).getValue() <= (value as! ContinuousAttribute).getValue()
                    } else {
                        if comparison == ">" {
                            return (instance.getAttribute(index: attributeIndex) as! ContinuousAttribute).getValue() > (value as! ContinuousAttribute).getValue()
                        }
                    }
                }
            }
        }
        return false
    }
}
