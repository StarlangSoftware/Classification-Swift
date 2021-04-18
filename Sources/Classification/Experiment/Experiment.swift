//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.04.2021.
//

import Foundation

public class Experiment{
    
    private var classifier: Classifier
    private var parameter: Parameter
    private var dataSet: DataSet
    
    /**
     * Constructor for a specific machine learning experiment
     - Parameters:
        - classifier: Classifier used in the machine learning experiment
        - parameter: Parameter(s) of the classifier.
        - dataSet: DataSet on which the classifier is run.
     */
    public init(classifier: Classifier, parameter: Parameter, dataSet: DataSet){
        self.classifier = classifier
        self.parameter = parameter
        self.dataSet = dataSet
    }
    
    /**
     * Accessor for the classifier attribute.
     - Returns: Classifier attribute.
     */
    public func getClassifier() -> Classifier{
        return classifier
    }
    
    /**
     * Accessor for the parameter attribute.
     - Returns: Parameter attribute.
     */
    public func getParameter() -> Parameter{
        return parameter
    }
    
    /**
     * Accessor for the dataSet attribute.
     - Returns: DataSet attribute.
     */
    public func getDataSet() -> DataSet{
        return dataSet
    }
}
