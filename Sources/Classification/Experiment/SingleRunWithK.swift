//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 18.04.2021.
//

import Foundation
import Sampling

public class SingleRunWithK : SingleRun{
    
    private var K: Int
    
    /**
     * Constructor for SingleRunWithK class. Basically sets K parameter of the K-fold cross-validation.
     - Parameters:
        - K: K of the K-fold cross-validation.
     */
    public init(K: Int){
        self.K = K
    }
    
    /// Runs first fold of a K fold cross-validated experiment for the given classifier with the given parameters.
    /// The experiment result will be returned.
    /// - Parameters:
    ///   - classifier: Classifier for the experiment
    ///   - parameter: Hyperparameters of the classifier of the experiment
    ///   - crossValidation: K-fold crossvalidated dataset.
    /// - Returns: The experiment result of the first fold of the K-fold cross-validated experiment.
    public func runExperiment(classifier: Classifier, parameter: Parameter, crossValidation: CrossValidation<Instance>) -> Performance{
        let trainSet = InstanceList(list: crossValidation.getTrainFold(k: 0))
        let testSet = InstanceList(list: crossValidation.getTestFold(k: 0))
        return classifier.singleRun(parameter: parameter, trainSet: trainSet, testSet: testSet)
    }
    
    /**
     * Execute Single K-fold cross-validation with the given classifier on the given data set using the given parameters.
     - Parameters:
        - experiment: Experiment to be run.
     - Returns: A Performance instance
     */
    public func execute(experiment: Experiment) -> Performance {
        let crossValidation = KFoldCrossValidation<Instance>(instanceList: experiment.getDataSet().getInstances(), K: K, seed: experiment.getParameter().getSeed())
        return runExperiment(classifier: experiment.getClassifier(), parameter: experiment.getParameter(), crossValidation: crossValidation)
    }
}
