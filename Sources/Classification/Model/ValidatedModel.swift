//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation

public class ValidatedModel : Model{
    
    /**
     * The testClassifier method takes an {@link InstanceList} as an input and returns an accuracy value as {@link ClassificationPerformance}.
     - Parameters:
        - data: {@link InstanceList} to test.
     - Returns: Accuracy value as {@link ClassificationPerformance}.
     */
    public func testClassifier(data: InstanceList) -> ClassificationPerformance{
        let total = data.size()
        var count : Int = 0
        for i in 0..<data.size() {
            if data.get(index: i).getClassLabel() == predict(instance: data.get(index: i)) {
                count += 1
            }
        }
        return ClassificationPerformance(accuracy: Double(count) / Double(total))
    }
}
