//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 14.04.2021.
//

import Foundation

public class Performance{
    
    public var errorRate: Double
    
    /**
     * Constructor that sets the error rate.
     - Parameters:
        - errorRate: Double input.
     */
    public init(errorRate: Double){
        self.errorRate = errorRate
    }
    
    /**
     * Accessor for the error rate.
     *
        - Returns: Double errorRate.
     */
    public func getErrorRate() -> Double{
        return errorRate
    }
}
