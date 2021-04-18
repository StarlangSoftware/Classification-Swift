//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class LaryToBinary : LaryFilter{
    
    /**
     * Constructor for L-ary discrete to binary discrete filter.
     - Parameters:
        - dataSet: The instances whose L-ary discrete attributes will be converted to binary discrete attributes.
     */
    public override init(dataSet: DataSet) {
        super.init(dataSet: dataSet)
    }
    
    /**
     * Converts discrete attributes of a single instance to binary discrete version using 1-of-L encoding. For example, if
     * an attribute has values red, green, blue; this attribute will be converted to 3 binary attributes where
     * red will have the value true false false, green will have the value false true false, and blue will have the value false false true.
     - Parameters:
        - instance: The instance to be converted.
     */
    public override func convertInstance(instance: Instance){
        let size = instance.attributeSize()
        for i in 0..<size {
            if attributeDistributions[i].size() > 0 {
                let index = attributeDistributions[i].getIndex(item: instance.getAttribute(index: i).description())
                for j in 0..<attributeDistributions[i].size() {
                    if j != index {
                        instance.addAttribute(attribute: BinaryAttribute(value: false))
                    } else {
                        instance.addAttribute(attribute: BinaryAttribute(value: true))
                    }
                }
            }
        }
        removeDiscreteAttributes(instance: instance, size: size)
    }
    
    /**
     * Converts the data definition with L-ary discrete attributes, to data definition with binary discrete attributes.
     */
    public override func convertDataDefinition() {
        let dataDefinition = dataSet.getDataDefinition()
        let size = dataDefinition.attributeCount()
        for i in 0..<size {
            if attributeDistributions[i].size() > 0 {
                for _ in 0..<attributeDistributions[i].size() {
                    dataDefinition.addAttribute(attributeType: AttributeType.BINARY)
                }
            }
        }
        removeDiscreteAttributes(size: size)
    }
}
