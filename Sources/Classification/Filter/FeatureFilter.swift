//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class FeatureFilter{
    
    public var dataSet: DataSet
    
    public func convertInstance(instance: Instance){}
    
    public func convertDataDefinition(){}
    
    /**
     * Constructor that sets the dataSet.
     - Parameters:
        - dataSet: DataSet that will bu used.
     */
    public init(dataSet: DataSet){
        self.dataSet = dataSet
    }
    
    public func convert(){
        let instances : [Instance] = dataSet.getInstances()
        for instance in instances{
            convertInstance(instance: instance)
        }
        convertDataDefinition()
    }
}
