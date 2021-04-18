//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 13.04.2021.
//

import Foundation

public class InstanceListOfSameClass : InstanceList{
    
    private var classLabel: String
    
    /**
     * Constructor for creating a new instance list with the same class label.
     - Parameters:
        - classLabel: Class label of instance list.
     */
    public init(classLabel: String){
        self.classLabel = classLabel
        super.init()
    }
    
    /**
     * Accessor for the class label.
     *
        - Returns: Class label.
     */
    public func getClassLabel() -> String{
        return classLabel
    }
}
