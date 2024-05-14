//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 18.04.2021.
//

import Foundation
import Sampling

public class StratifiedMxKFoldRun : MxKFoldRun{
    
    /**
     * Constructor for StratifiedMxKFoldRun class. Basically sets K parameter of the K-fold cross-validation and M for the number of times.
     - Parameters:
        - M: number of cross-validation times.
        - K: K of the K-fold cross-validation.
     */
    public override init(M: Int, K: Int){
        super.init(M: M, K: K)
    }
    
    /// Execute the Stratified MxK-fold cross-validation with the given classifier on the given data set using the given parameters.
    /// - Parameter experiment: Experiment to be run.
    /// - Returns: An ExperimentPerformance instance.
    public override func execute(experiment: Experiment) -> ExperimentPerformance {
        let result = ExperimentPerformance()
        for _ in 0..<M {
            let crossValidation = StratifiedKFoldCrossValidation<Instance>(instanceLists: experiment.getDataSet().getClassInstances(), K: K, seed: experiment.getParameter().getSeed())
            runExperiment(classifier: experiment.getClassifier(), parameter: experiment.getParameter(), experimentPerformance: result, crossValidation: crossValidation)
        }
        return result
    }
}
