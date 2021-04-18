//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class DiscreteToIndexed : LaryFilter{
    
    /**
     * Constructor for discrete to indexed filter.
     - Parameters:
        - dataSet: The dataSet whose instances whose discrete attributes will be converted to indexed attributes
     */
    public override init(dataSet: DataSet) {
        super.init(dataSet: dataSet)
    }
    
    /**
     * Converts discrete attributes of a single instance to indexed version.
     - Parameters:
        - instance: The instance to be converted.
     */
    public override func convertInstance(instance: Instance) {
        let size = instance.attributeSize()
        for i in 0..<size {
            if attributeDistributions[i].size() > 0 {
                let index = attributeDistributions[i].getIndex(item: instance.getAttribute(index: i).description())
                instance.addAttribute(attribute: DiscreteIndexedAttribute(value: instance.getAttribute(index: i).description(), index: index, maxIndex: attributeDistributions[i].size()))
            }
        }
        removeDiscreteAttributes(instance: instance, size: size)
    }
    
    /**
     * Converts the data definition with discrete attributes, to data definition with DISCRETE_INDEXED attributes.
     */
    public override func convertDataDefinition(){
        let dataDefinition = dataSet.getDataDefinition()
        let size = dataDefinition.attributeCount()
        for i in 0..<size {
            if attributeDistributions[i].size() > 0 {
                dataDefinition.addAttribute(attributeType: AttributeType.DISCRETE_INDEXED)
            }
        }
        removeDiscreteAttributes(size: size)
    }
}
