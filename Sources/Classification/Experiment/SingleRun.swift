//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.04.2021.
//

import Foundation

protocol SingleRun {
    
    func execute(experiment: Experiment) -> Performance
}
