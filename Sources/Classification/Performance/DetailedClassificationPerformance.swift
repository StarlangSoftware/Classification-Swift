//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class DetailedClassificationPerformance : ClassificationPerformance{
    
    private var confusionMatrix: ConfusionMatrix
    
    /**
     * A constructor that  sets the accuracy and errorRate as 1 - accuracy via given {@link ConfusionMatrix} and also sets the confusionMatrix.
     - Parameters:
        - confusionMatrix: {@link ConfusionMatrix} input.
     */
    public init(confusionMatrix: ConfusionMatrix){
        self.confusionMatrix = confusionMatrix
        super.init(accuracy: confusionMatrix.getAccuracy())
    }
    
    /**
     * Accessor for the confusionMatrix.
     *
        - Returns: ConfusionMatrix.
     */
    public func getConfusionMatrix() -> ConfusionMatrix{
        return confusionMatrix
    }
}
