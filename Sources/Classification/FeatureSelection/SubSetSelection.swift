//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 18.04.2021.
//

import Foundation

public class SubSetSelection{
    
    public var initialSubSet: FeatureSubSet
    
    /**
     * A constructor that sets the initial subset with given input.
     - Parameters:
        - initialSubSet: {@link FeatureSubSet} input.
     */
    public init(initialSubSet: FeatureSubSet){
        self.initialSubSet = initialSubSet
    }
    
    /**
     * The forward method starts with having no feature in the model. In each iteration, it keeps adding the features that are not currently listed.
     - Parameters:
        - currentSubSetList: ArrayList to add the FeatureSubsets.
        - current :          FeatureSubset that will be added to currentSubSetList.
        - numberOfFeatures:  The number of features to add the subset.
     */
    public func forward(currentSubSetList: inout [FeatureSubSet], current: FeatureSubSet, numberOfFeatures: Int){
        for i in 0..<numberOfFeatures {
            if !current.contains(featureNo: i) {
                let candidate : FeatureSubSet = current.copy() as! FeatureSubSet
                candidate.add(featureNo: i)
                currentSubSetList.append(candidate)
            }
        }
    }
    
    /**
     * The backward method starts with all the features and removes the least significant feature at each iteration.
     - Parameters:
        - currentSubSetList: ArrayList to add the FeatureSubsets.
        - current:           FeatureSubset that will be added to currentSubSetList
     */
    public func backward(currentSubSetList: inout [FeatureSubSet], current: FeatureSubSet){
        for i in 0..<current.size() {
            let candidate : FeatureSubSet = current.copy() as! FeatureSubSet
            candidate.remove(index: i)
            currentSubSetList.append(candidate)
        }
    }
    
    public func selectionOperator(current: FeatureSubSet, numberOfFeatures: Int) -> [FeatureSubSet]{
        return []
    }

    /**
     * The execute method takes an {@link Experiment} and a {@link MultipleRun} as inputs. By selecting a candidateList from given
     * Experiment it tries to find a FeatureSubSet that gives best performance.
     - Parameters:
        - multipleRun: {@link MultipleRun} type input.
        - experiment:  {@link Experiment} type input.
     - Returns: FeatureSubSet that gives best performance.
     */
    public func execute(multipleRun: MultipleRun, experiment: Experiment) -> FeatureSubSet{
        var processed : Set<FeatureSubSet> = []
        var best : FeatureSubSet = initialSubSet
        processed.insert(best)
        var betterFound : Bool = true
        var bestPerformance : ExperimentPerformance? = nil
        if best.size() > 0 {
            bestPerformance = multipleRun.execute(experiment: experiment.featureSelectedExperiment(featureSubSet: best))
        }
        while betterFound {
            betterFound = false
            let candidateList : [FeatureSubSet] = selectionOperator(current: best, numberOfFeatures: experiment.getDataSet().getDataDefinition().attributeCount())
            for candidateSubSet in candidateList {
                if !processed.contains(candidateSubSet) {
                    if candidateSubSet.size() > 0 {
                        let currentPerformance = multipleRun.execute(experiment: experiment.featureSelectedExperiment(featureSubSet: candidateSubSet))
                        if bestPerformance == nil || currentPerformance.isBetter(experimentPerformance: bestPerformance!) {
                            best = candidateSubSet
                            bestPerformance = currentPerformance
                            betterFound = true
                        }
                    }
                    processed.insert(candidateSubSet)
                }
            }
        }
        return best
    }
}
