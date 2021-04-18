//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation

public class KnnInstance : Comparable{
    
    private var distance: Double
    private var instance: Instance
    
    /**
     * The constructor that sets the instance and distance value.
     - Parameters:
        - instance: {@link Instance} input.
        - distance: Double distance value.
     */
    public init(instance: Instance, distance: Double){
        self.distance = distance
        self.instance = instance
    }
    
    public static func < (lhs: KnnInstance, rhs: KnnInstance) -> Bool {
        return lhs.distance < rhs.distance
    }
    
    public static func == (lhs: KnnInstance, rhs: KnnInstance) -> Bool {
        return lhs.distance == rhs.distance
    }
    
    public func getInstance() -> Instance{
        return instance
    }

}
