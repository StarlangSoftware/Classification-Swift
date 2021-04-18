//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation

public class Classifier {
    
    public var model: Model = Model()
    
    public func train(trainSet: InstanceList, parameters: Parameter){}
    
    /**
     * Checks given instance's attribute and returns true if it is a discrete indexed attribute, false otherwise.
     - Parameters:
        - instance: Instance to check.
     - Returns: True if instance is a discrete indexed attribute, false otherwise.
     */
    public func discreteCheck(instance: Instance) -> Bool{
        for i in 0..<instance.attributeSize() {
            if instance.getAttribute(index: i) is DiscreteAttribute && !(instance.getAttribute(index: i) is DiscreteIndexedAttribute) {
                return false
            }
        }
        return true
    }
    
    /**
     * TestClassification an instance list with the current model.
     - Parameters:
        - testSet: Test data (list of instances) to be tested.
     - Returns: The accuracy (and error) of the model as an instance of Performance class.
     */
    public func test(testSet: InstanceList) -> Performance{
        let classLabels : [String] = testSet.getUnionOfPossibleClassLabels()
        let confusion : ConfusionMatrix = ConfusionMatrix(classLabels: classLabels)
        for i in 0..<testSet.size() {
            let instance = testSet.get(index: i)
            confusion.classify(actualClass: instance.getClassLabel(), predictedClass: model.predict(instance: instance))
        }
        return DetailedClassificationPerformance(confusionMatrix: confusion)
    }
    
    /**
     * Runs current classifier with the given train and test data.
     - Parameters:
        - parameter: Parameter of the classifier to be trained.
        - trainSet:  Training data to be used in training the classifier.
        - testSet:   Test data to be tested after training the model.
     - Returns: The accuracy (and error) of the trained model as an instance of Performance class.
     */
    public func singleRun(parameter: Parameter, trainSet: InstanceList, testSet: InstanceList) -> Performance{
        train(trainSet: trainSet, parameters: parameter)
        return test(testSet: testSet)
    }
    
    /**
     * Accessor for the model.
     *
        - Returns: Model.
     */
    public func getModel() -> Model{
        return model
    }
}
