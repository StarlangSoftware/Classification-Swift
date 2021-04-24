//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 12.04.2021.
//

import Foundation
import DataStructure

public class Model{
    
    /**
     * An abstract predict method that takes an {@link Instance} as an input.
     - Parameters:
        - instance: {@link Instance} to make prediction.
     - Returns: The class label as a String.
     */
    public func predict(instance: Instance) -> String{
        return ""
    }
    
    public func predictProbability(instance: Instance) -> [String: Double] {
        return [:]
    }
    
    public static func getMaximum(classLabels: [String]) -> String{
        let frequencies : CounterHashMap<String> = CounterHashMap()
        for label in classLabels{
            frequencies.put(key: label)
        }
        return frequencies.max()!
    }
}
