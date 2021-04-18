//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class DiscreteToContinuous : LaryFilter{
    
    /**
     * Constructor for discrete to continuous filter.
     - Parameters:
        - dataSet: The dataSet whose instances whose discrete attributes will be converted to continuous attributes using 1-of-L encoding.
     */
    public override init(dataSet: DataSet) {
        super.init(dataSet: dataSet)
    }
    
    /**
     * Converts discrete attributes of a single instance to continuous version using 1-of-L encoding. For example, if
     * an attribute has values red, green, blue; this attribute will be converted to 3 continuous attributes where
     * red will have the value 100, green will have the value 010, and blue will have the value 001.
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
                        instance.addAttribute(attribute: ContinuousAttribute(value: 0))
                    } else {
                        instance.addAttribute(attribute: ContinuousAttribute(value: 1))
                    }
                }
            }
        }
        removeDiscreteAttributes(instance: instance, size: size)
    }
    
    public override func convertDataDefinition(){
        let dataDefinition = dataSet.getDataDefinition()
        let size = dataDefinition.attributeCount()
        for i in 0..<size {
            if attributeDistributions[i].size() > 0 {
                for _ in 0..<attributeDistributions[i].size() {
                    dataDefinition.addAttribute(attributeType: AttributeType.CONTINUOUS)
                }
            }
        }
        removeDiscreteAttributes(size: size)
    }
}
