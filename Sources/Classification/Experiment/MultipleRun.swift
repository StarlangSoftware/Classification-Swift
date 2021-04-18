//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.04.2021.
//

import Foundation

public protocol MultipleRun {
    
    func execute(experiment: Experiment) -> ExperimentPerformance
}
