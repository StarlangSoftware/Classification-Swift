//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 18.04.2021.
//

import Foundation
import Sampling

public class KFoldRun : MultipleRun{

    public var K: Int
    
    /**
     * Constructor for KFoldRun class. Basically sets K parameter of the K-fold cross-validation.
     - Parameters:
        - K: K of the K-fold cross-validation.
     */
    public init(K: Int){
        self.K = K
    }
    
    /// Runs a K fold cross-validated experiment for the given classifier with the given parameters. The experiment
    /// results will be added to the experimentPerformance.
    /// - Parameters:
    ///   - classifier: Classifier for the experiment
    ///   - parameter: Hyperparameters of the classifier of the experiment
    ///   - experimentPerformance: Storage to add experiment results
    ///   - crossValidation: K-fold crossvalidated dataset.
    public func runExperiment(classifier: Classifier, parameter: Parameter, experimentPerformance: ExperimentPerformance, crossValidation: CrossValidation<Instance>){
        for i in 0..<K {
            let trainSet = InstanceList(list: crossValidation.getTrainFold(k: i))
            let testSet = InstanceList(list: crossValidation.getTestFold(k: i))
            classifier.train(trainSet: trainSet, parameters: parameter)
            experimentPerformance.add(performance: classifier.test(testSet: testSet))
        }
    }
    
    /**
     * Execute K-fold cross-validation with the given classifier on the given data set using the given parameters.
     - Parameters:
        - experiment: Experiment to be run.
     - Returns: An ExperimentPerformance instance.
     */
    public func execute(experiment: Experiment) -> ExperimentPerformance {
        let result = ExperimentPerformance()
        let crossValidation =  KFoldCrossValidation<Instance>(instanceList: experiment.getDataSet().getInstances(), K: K, seed: experiment.getParameter().getSeed())
        runExperiment(classifier: experiment.getClassifier(), parameter: experiment.getParameter(), experimentPerformance: result, crossValidation: crossValidation)
        return result
    }
}
