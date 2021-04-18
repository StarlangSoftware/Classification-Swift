//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 18.04.2021.
//

import Foundation
import Sampling

public class StratifiedKFoldRun : KFoldRun{
    
    /**
     * Constructor for KFoldRun class. Basically sets K parameter of the K-fold cross-validation.
     - Parameters:
        - K: K of the K-fold cross-validation.
     */
    public override init(K: Int) {
        super.init(K: K)
    }
    
    /**
     * Execute Stratified K-fold cross-validation with the given classifier on the given data set using the given parameters.
     - Parameters:
        - experiment: Experiment to be run.
     - Returns: An ExperimentPerformance instance.
     */
    public override func execute(experiment: Experiment) -> ExperimentPerformance {
        let result = ExperimentPerformance()
        let crossValidation = StratifiedKFoldCrossValidation<Instance>(instanceLists: experiment.getDataSet().getClassInstances(), K: K, seed: experiment.getParameter().getSeed())
        runExperiment(classifier: experiment.getClassifier(), parameter: experiment.getParameter(), experimentPerformance: result, crossValidation: crossValidation)
        return result
    }
}
