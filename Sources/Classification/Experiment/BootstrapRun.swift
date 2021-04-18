//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.04.2021.
//

import Foundation
import Sampling

public class BootstrapRun : MultipleRun{
    
    private var numberOfBootstraps : Int
    
    /**
     * Constructor for BootstrapRun class. Basically sets the number of bootstrap runs.
     - Parameters:
        - numberOfBootstraps: Number of bootstrap runs.
     */
    public init(numberOfBootstraps: Int){
        self.numberOfBootstraps = numberOfBootstraps
    }
    
    /**
     * Execute the bootstrap run with the given classifier on the given data set using the given parameters.
     - Parameters:
        - experiment: Experiment to be run.
     - Returns: An ExperimentPerformance instance.
     */
    public func execute(experiment: Experiment) -> ExperimentPerformance {
        let result = ExperimentPerformance()
        for i in 0..<numberOfBootstraps {
            let bootstrap = Bootstrap<Instance>(instanceList: experiment.getDataSet().getInstances(), seed: i + experiment.getParameter().getSeed())
            let bootstrapSample = InstanceList(list: bootstrap.getSample())
            experiment.getClassifier().train(trainSet: bootstrapSample, parameters: experiment.getParameter())
            result.add(performance: experiment.getClassifier().test(testSet: experiment.getDataSet().getInstanceList()))
        }
        return result
    }
}
