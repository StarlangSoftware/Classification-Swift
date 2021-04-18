//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 18.04.2021.
//

import Foundation
import Sampling

public class StratifiedSingleRunWithK{
    
    private var K: Int
    
    /**
     * Constructor for StratifiedSingleRunWithK class. Basically sets K parameter of the K-fold cross-validation.
     - Parameters:
        - K: K of the K-fold cross-validation.
     */
    public init(K: Int){
        self.K = K
    }
    
    /**
     * Execute Stratified Single K-fold cross-validation with the given classifier on the given data set using the given parameters.
     - Parameters:
        - experiment: Experiment to be run.
     - Returns: A Performance instance.
     */
    public func execute(experiment: Experiment) -> Performance{
        let crossValidation = StratifiedKFoldCrossValidation<Instance>(instanceLists: experiment.getDataSet().getClassInstances(), K: K, seed: experiment.getParameter().getSeed())
        let trainSet = InstanceList(list: crossValidation.getTrainFold(k: 0))
        let testSet = InstanceList(list: crossValidation.getTestFold(k: 0))
        return experiment.getClassifier().singleRun(parameter: experiment.getParameter(), trainSet: trainSet, testSet: testSet)
    }
}
