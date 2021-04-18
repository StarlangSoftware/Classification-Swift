//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 18.04.2021.
//

import Foundation
import Sampling

public class StratifiedMxKFoldRunSeparateTest : StratifiedKFoldRunSeparateTest{
    
    public var M: Int
    
    /**
     * Constructor for StratifiedMxKFoldRunSeparateTest class. Basically sets K parameter of the K-fold cross-validation and M for the number of times.
     - Parameters:
        - M: number of cross-validation times.
        - K: K of the K-fold cross-validation.
     */
    public init(M: Int, K: Int){
        self.M = M
        super.init(K: K)
    }
    
    /**
     * Execute the Stratified MxK-fold cross-validation with the given classifier on the given data set using the given parameters.
     - Parameters:
        - experiment: Experiment to be run.
     - Returns: An ExperimentPerformance instance.
     */
    public override func execute(experiment: Experiment) -> ExperimentPerformance {
        let result = ExperimentPerformance()
        for _ in 0..<M {
            let instanceList = experiment.getDataSet().getInstanceList()
            let partition = Partition(instanceList: instanceList, ratio: 0.25, stratified: true)
            let crossValidation = StratifiedKFoldCrossValidation<Instance>( instanceLists: Partition(instanceList: partition.get(index: 1)).getLists(), K: K, seed: experiment.getParameter().getSeed())
            runExperiment(classifier: experiment.getClassifier(), parameter: experiment.getParameter(), experimentPerformance: result, crossValidation: crossValidation, testSet: partition.get(index: 0))
        }
        return result
    }
}
