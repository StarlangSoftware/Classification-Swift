//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 14.04.2021.
//

import Foundation
import DataStructure

public class ConfusionMatrix{
    
    private var matrix : Dictionary<String, CounterHashMap<String>>
    private var classLabels : [String]
    
    /**
     * Constructor that sets the class labels {@link ArrayList} and creates new {@link HashMap} matrix
     - Parameters:
        - classLabels: {@link ArrayList} of String.
     */
    public init(classLabels: [String]){
        self.classLabels = classLabels
        matrix = Dictionary<String, CounterHashMap<String>>()
    }
    
    /**
     * The classify method takes two Strings; actual class and predicted class as inputs. If the matrix {@link HashMap} contains
     * given actual class String as a key, it then assigns the corresponding object of that key to a {@link CounterHashMap}, if not
     * it creates a new {@link CounterHashMap}. Then, it puts the given predicted class String to the counterHashMap and
     * also put this counterHashMap to the matrix {@link HashMap} together with the given actual class String.
     - Parameters:
        - actualClass:    String input actual class.
        - predictedClass: String input predicted class.
     */
    public func classify(actualClass: String, predictedClass: String){
        var counterHashMap : CounterHashMap<String>
        if matrix[actualClass] != nil{
            counterHashMap = matrix[actualClass]!
        } else {
            counterHashMap = CounterHashMap<String>()
        }
        counterHashMap.put(key: predictedClass)
        matrix[actualClass] = counterHashMap
    }
    
    /**
     * The addConfusionMatrix method takes a {@link ConfusionMatrix} as an input and loops through actual classes of that {@link HashMap}
     * and initially gets one row at a time. Then it puts the current row to the matrix {@link HashMap} together with the actual class string.
     - Parameters:
        - confusionMatrix: {@link ConfusionMatrix} input.
     */
    public func addConfusionMatrix(confusionMatrix: ConfusionMatrix){
        for actualClass in confusionMatrix.matrix.keys{
            let rowToBeAdded = confusionMatrix.matrix[actualClass]
            if matrix[actualClass] != nil{
                let currentRow = matrix[actualClass]
                currentRow?.add(toBeAdded: rowToBeAdded!)
                matrix[actualClass] = currentRow
            } else {
                matrix[actualClass] = rowToBeAdded
            }
        }
    }
    
    /**
     * The sumOfElements method loops through the keys in matrix {@link HashMap} and returns the summation of all the values of the keys.
     * I.e: TP+TN+FP+FN.
     *
        - Returns: The summation of values.
     */
    private func sumOfElements() -> Double{
        var result : Double = 0.0
        for actualClass in matrix.keys{
            result += Double((matrix[actualClass]?.sumOfCounts())!)
        }
        return result
    }
    
    /**
     * The trace method loops through the keys in matrix {@link HashMap} and if the current key contains the actual key,
     * it accumulates the corresponding values. I.e: TP+TN.
     *
        - Returns: Summation of values.
     */
    private func trace() -> Double{
        var result : Double = 0.0
        for actualClass in matrix.keys{
            if matrix[actualClass]?.count(key: actualClass) != 0{
                result += Double((matrix[actualClass]?.count(key: actualClass))!)
            }
        }
        return result
    }
    
    /**
     * The columnSum method takes a String predicted class as input, and loops through the keys in matrix {@link HashMap}.
     * If the current key contains the predicted class String, it accumulates the corresponding values. I.e: TP+FP.
     - Parameters:
        - predictedClass: String input predicted class.
     - Returns: Summation of values.
     */
    private func columnSum(predictedClass: String) -> Double{
        var result: Double = 0.0
        for actualClass in matrix.keys{
            if matrix[actualClass]?.count(key: predictedClass) != 0{
                result += Double((matrix[actualClass]?.count(key: predictedClass))!)
            }
        }
        return result
    }
    
    /**
     * The getAccuracy method returns the result of  TP+TN / TP+TN+FP+FN
     *
        - Returns: the result of  TP+TN / TP+TN+FP+FN
     */
    public func getAccuracy() -> Double{
        return trace() / sumOfElements()
    }
    
    /**
     * The precision method loops through the class labels and returns the resulting Array which has the result of TP/FP+TP.
     *
        - Returns: The result of TP/FP+TP.
     */
    public func precision() -> [Double]{
        var result : [Double] = []
        for i in 0..<classLabels.count{
            let actualClass = classLabels[i]
            if matrix[actualClass] != nil{
                result.append(Double((matrix[actualClass]?.count(key: actualClass))!) / columnSum(predictedClass: actualClass))
            } else {
                result.append(0.0)
            }
        }
        return result
    }
    
    /**
     * The recall method loops through the class labels and returns the resulting Array which has the result of TP/FN+TP.
     *
        - Returns: The result of TP/FN+TP.
     */
    public func recall() -> [Double]{
        var result : [Double] = []
        for i in 0..<classLabels.count{
            let actualClass = classLabels[i]
            if matrix[actualClass] != nil{
                result.append(Double((matrix[actualClass]?.count(key: actualClass))!) / Double((matrix[actualClass]?.sumOfCounts())!))
            } else {
                result.append(0.0)
            }
        }
        return result
    }
    
    /**
     * The fMeasure method loops through the class labels and returns the resulting Array which has the average of
     * recall and precision.
     *
        - Returns: The average of recall and precision.
     */
    public func fMeasure() -> [Double]{
        let precisionVector = precision()
        let recallVector = recall()
        var result : [Double] = []
        for i in 0..<classLabels.count {
            result[i] = 2 / (1 / precisionVector[i] + 1 / recallVector[i])
        }
        return result
    }
    
    /**
     * The weightedFMeasure method loops through the class labels and returns the resulting Array which has the weighted average of
     * recall and precision.
     *
        - Returns: The weighted average of recall and precision.
     */
    public func weightedFMeasure() -> Double{
        let fMeasureVector = fMeasure()
        var sum : Double = 0.0
        for i in 0..<classLabels.count {
            let actualClass = classLabels[i]
            sum += fMeasureVector[i] * Double((matrix[actualClass]?.sumOfCounts())!)
        }
        return sum / sumOfElements()
    }
}
