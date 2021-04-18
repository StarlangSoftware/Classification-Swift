//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation
import Math

public class LaryFilter : FeatureFilter{
    
    public var attributeDistributions: [DiscreteDistribution]
    
    /**
     * Constructor that sets the dataSet and all the attributes distributions.
     - Parameters:
        - dataSet: DataSet that will bu used.
     */
    public override init(dataSet: DataSet){
        attributeDistributions = dataSet.getInstanceList().allAttributesDistribution()
        super.init(dataSet: dataSet)
    }
    
    /**
     * The removeDiscreteAttributes method takes an {@link Instance} as an input, and removes the discrete attributes from
     * given instance.
     - Parameters:
        - instance: Instance to removes attributes from.
        - size:     Size of the given instance.
     */
    public func removeDiscreteAttributes(instance: Instance, size: Int){
        var k : Int = 0
        for i in 0..<size {
            if attributeDistributions[i].size() > 0 {
                instance.removeAttribute(index: k)
            } else {
                k += 1
            }
        }
    }
    
    /**
     * The removeDiscreteAttributes method removes the discrete attributes from dataDefinition.
     - Parameters:
        - size: Size of item that attributes will be removed.
     */
    public func removeDiscreteAttributes(size: Int){
        let dataDefinition = dataSet.getDataDefinition()
        var k : Int = 0
        for i in 0..<size {
            if attributeDistributions[i].size() > 0 {
                dataDefinition.removeAttribute(index: k)
            } else {
                k += 1
            }
        }
    }
}
