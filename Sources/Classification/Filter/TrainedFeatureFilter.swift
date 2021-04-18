//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class TrainedFeatureFilter : FeatureFilter{
    
    public func train(){}
    
    /**
     * Constructor that sets the dataSet.
     - Parameters:
        - dataSet: DataSet that will bu used.
     */
    public override init(dataSet: DataSet) {
        super.init(dataSet: dataSet)
    }
}
