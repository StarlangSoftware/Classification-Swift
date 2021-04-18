//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 18.04.2021.
//

import Foundation
import Sampling

public class StratifiedKFoldRunSeparateTest : KFoldRunSeparateTest{
    
    /**
     * Constructor for StratifiedKFoldRunSeparateTest class. Basically sets K parameter of the K-fold cross-validation.
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
        let instanceList = experiment.getDataSet().getInstanceList()
        let partition = Partition(instanceList: instanceList, ratio: 0.25, stratified: true)
        let crossValidation = StratifiedKFoldCrossValidation<Instance>( instanceLists: Partition(instanceList: partition.get(index: 1)).getLists(), K: K, seed: experiment.getParameter().getSeed())
        runExperiment(classifier: experiment.getClassifier(), parameter: experiment.getParameter(), experimentPerformance: result, crossValidation: crossValidation, testSet: partition.get(index: 0))
        return result
    }
}
