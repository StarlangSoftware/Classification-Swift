//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public protocol DistanceMetric {
    
    func distance(instance1: Instance, instance2: Instance) -> Double
}
