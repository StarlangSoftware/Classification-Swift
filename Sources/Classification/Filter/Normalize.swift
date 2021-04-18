//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class Normalize : FeatureFilter{
    
    private var averageInstance : Instance
    private var standardDeviationInstance : Instance
    
    /**
     * Constructor for normalize feature filter. It calculates and stores the mean (m) and standard deviation (s) of
     * the sample.
     - Parameters:
        - dataSet: Instances whose continuous attribute values will be normalized.
     */
    public override init(dataSet: DataSet) {
        averageInstance = dataSet.getInstanceList().average()
        standardDeviationInstance = dataSet.getInstanceList().standardDeviation()
        super.init(dataSet: dataSet)
    }
    
    /**
     * Normalizes the continuous attributes of a single instance. For all i, new x_i = (x_i - m_i) / s_i.
     - Parameters:
        - instance: Instance whose attributes will be normalized.
     */
    public override func convertInstance(instance: Instance) {
        for i in 0..<instance.attributeSize() {
            if instance.getAttribute(index: i) is ContinuousAttribute {
                let xi = instance.getAttribute(index: i) as! ContinuousAttribute
                let mi = averageInstance.getAttribute(index: i) as! ContinuousAttribute
                let si = standardDeviationInstance.getAttribute(index: i) as! ContinuousAttribute
                xi.setValue(value: (xi.getValue() - mi.getValue()) / si.getValue())
            }
        }
    }
    
    public override func convertDataDefinition() {
        
    }
}
