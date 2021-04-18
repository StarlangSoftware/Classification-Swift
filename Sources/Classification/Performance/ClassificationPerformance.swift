//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 14.04.2021.
//

import Foundation

public class ClassificationPerformance : Performance{
    
    private var accuracy: Double
    
    /**
     * A constructor that sets the accuracy and errorRate as 1 - accuracy via given accuracy.
     - Parameters:
        - accuracy: Double value input.
     */
    public init(accuracy: Double){
        self.accuracy = accuracy
        super.init(errorRate: 1 - accuracy)
    }
    
    /**
     * A constructor that sets the accuracy and errorRate via given input.
     - Parameters:
        - accuracy:  Double value input.
        - errorRate: Double value input.
     */
    public init(accuracy: Double, errorRate: Double){
        self.accuracy = accuracy
        super.init(errorRate: errorRate)
    }
    
    /**
     * Accessor for the accuracy.
     *
        - Returns: Accuracy value.
     */
    public func getAccuracy() -> Double{
        return accuracy
    }
}
