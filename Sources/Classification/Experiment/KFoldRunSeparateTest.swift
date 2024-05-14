//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 18.04.2021.
//

import Foundation
import Sampling

public class KFoldRunSeparateTest : KFoldRun{
    
    /**
     * Constructor for KFoldRunSeparateTest class. Basically sets K parameter of the K-fold cross-validation.
     - Parameters:
        - K: K of the K-fold cross-validation.
     */
    public override init(K: Int){
        super.init(K: K)
    }
    
    /// Runs a K fold cross-validated experiment for the given classifier with the given parameters. Testing will be
    /// done on the separate test set. The experiment results will be added to the experimentPerformance.
    /// - Parameters:
    ///   - classifier: Classifier for the experiment
    ///   - parameter: Hyperparameters of the classifier of the experiment
    ///   - experimentPerformance: Storage to add experiment results
    ///   - crossValidation: K-fold crossvalidated dataset.
    ///   - testSet: Test set on which experiment performance is calculated.
    public func runExperiment(classifier: Classifier, parameter: Parameter, experimentPerformance: ExperimentPerformance, crossValidation: CrossValidation<Instance>, testSet: InstanceList) {
        for i in 0..<K {
            let trainSet = InstanceList(list: crossValidation.getTrainFold(k: i))
            classifier.train(trainSet: trainSet, parameters: parameter)
            experimentPerformance.add(performance: classifier.test(testSet: testSet))
        }
    }
    
    /**
     * Execute K-fold cross-validation with separate test set with the given classifier on the given data set using the given parameters.
     - Parameters:
        - experiment: Experiment to be run.
     - Returns: An ExperimentPerformance instance.
     */
    public override func execute(experiment: Experiment) -> ExperimentPerformance {
        let result = ExperimentPerformance()
        let instanceList = experiment.getDataSet().getInstanceList()
        let partition = Partition(instanceList: instanceList, ratio: 0.25, stratified: true)
        let crossValidation = KFoldCrossValidation<Instance>(instanceList: partition.get(index: 1).getInstances(), K: K, seed: experiment.getParameter().getSeed())
        runExperiment(classifier: experiment.getClassifier(), parameter: experiment.getParameter(), experimentPerformance: result, crossValidation: crossValidation, testSet: partition.get(index: 0))
        return result
    }
}
