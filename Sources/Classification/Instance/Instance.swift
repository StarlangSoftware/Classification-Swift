//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 11.04.2021.
//

import Foundation
import Math

public class Instance {
    
    private var classLabel: String
    private var attributes: [Attribute]
    
    /**
     * Constructor for a single instance. Given the attributes and class label, it generates a new instance.
     - Parameters:
        - classLabel: Class label of the instance.
        - attributes: Attributes of the instance.
     */
    public init(classLabel: String, attributes: [Attribute]){
        self.classLabel = classLabel
        self.attributes = attributes
    }
    
    /**
     * Constructor for a single instance. Given the class label, it generates a new instance with 0 attributes.
     * Attributes must be added later with different addAttribute methods.
     - Parameters:
        - classLabel: Class label of the instance.
     */
    public init(classLabel: String){
        self.classLabel = classLabel
        self.attributes = []
    }
    
    /**
     * Adds a discrete attribute with the given {@link String} value.
     - Parameters:
        - value: Value of the discrete attribute.
     */
    public func addAttribute(value: String){
        attributes.append(DiscreteAttribute(value: value))
    }
    
    /**
     * Adds a continuous attribute with the given {@link double} value.
     - Parameters:
        - value: Value of the continuous attribute.
     */
    public func addAttribute(value: Double){
        attributes.append(ContinuousAttribute(value: value))
    }
    
    /**
     * Adds a new attribute.
     - Parameters:
        - attribute: Attribute to be added.
     */
    public func addAttribute(attribute: Attribute){
        attributes.append(attribute)
    }
    
    /**
     * Adds a {@link Vector} of continuous attributes.
     - Parameters:
        - vector: {@link Vector} that has the continuous attributes.
     */
    public func addVectorAttribute(vector: Vector){
        for i in 0..<vector.size() {
            attributes.append(ContinuousAttribute(value: vector.getValue(index: i)))
        }
    }
    
    /**
     * Removes attribute with the given index from the attributes list.
     - Parameters:
        - index: Index of the attribute to be removed.
     */
    public func removeAttribute(index: Int){
        attributes.remove(at: index)
    }
    
    /**
     * Removes all the attributes from the attributes list.
     */
    public func removeAllAttributes(){
        attributes.removeAll()
    }
    
    /**
     * Accessor for a single attribute.
     - Parameters:
        - index: Index of the attribute to be accessed.
     - Returns: Attribute with index 'index'.
     */
    public func getAttribute(index: Int)-> Attribute{
        return attributes[index]
    }
    
    /**
     * Returns the number of attributes in the attributes list.
     *
        - Returns: Number of attributes in the attributes list.
     */
    public func attributeSize() -> Int{
        return attributes.count
    }
    
    /**
     * Returns the number of continuous and discrete indexed attributes in the attributes list.
     *
        - Returns: Number of continuous and discrete indexed attributes in the attributes list.
     */
    public func continuousAttributeSize() -> Int{
        var size : Int = 0
        for attribute in attributes {
            size += attribute.continuousAttributeSize()
        }
        return size
    }
    
    /**
     * The continuousAttributes method creates a new {@link ArrayList} result and it adds the continuous attributes of the
     * attributes list and also it adds 1 for the discrete indexed attributes
     *
        - Returns: result {@link ArrayList} that has continuous and discrete indexed attributes.
     */
    public func continuousAttributes() -> [Double] {
        var result : [Double] = []
        for attribute in attributes {
            result.append(contentsOf: attribute.continuousAttributes())
        }
        return result
    }
    
    /**
     * Accessor for the class label.
     *
        - Returns: Class label of the instance.
     */
    public func getClassLabel() -> String{
        return classLabel
    }
    
    public func description() -> String{
        var result : String = ""
        for attribute in attributes {
            result = result + attribute.description() + ","
        }
        result = result + classLabel
        return result
    }
    
    /**
     * The toVector method returns a {@link Vector} of continuous attributes and discrete indexed attributes.
     *
        - Returns: {@link Vector} of continuous attributes and discrete indexed attributes.
     */
    public func toVector() -> Vector{
        var values : [Double] = []
        for attribute in attributes {
            values.append(contentsOf: attribute.continuousAttributes())
        }
        return Vector(values: values)
    }
}
