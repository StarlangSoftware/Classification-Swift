//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation
import Math

public class NaiveBayes : Classifier{
    
    /**
     * Training algorithm for Naive Bayes algorithm with a continuous data set.
     - Parameters:
        - priorDistribution: Probability distribution of classes P(C_i)
        - classLists:        Instances are divided into K lists, where each list contains only instances from a single class
     */
    private func trainContinuousVersion(priorDistribution: DiscreteDistribution, classLists: Partition) {
        var classMeans : [String : Vector] = [:]
        var classDeviations : [String : Vector] = [:]
        for i in 0..<classLists.size() {
            let classLabel = (classLists.get(index: i) as! InstanceListOfSameClass).getClassLabel()
            let averageVector = classLists.get(index: i).average().toVector()
            classMeans[classLabel] = averageVector
            let standardDeviationVector = classLists.get(index: i).standardDeviation().toVector()
            classDeviations[classLabel] = standardDeviationVector
        }
        model = NaiveBayesModel(priorDistribution: priorDistribution, classMeans: classMeans, classDeviations: classDeviations)
    }
    
    /**
     * Training algorithm for Naive Bayes algorithm with a discrete data set.
     - Parameters:
        - priorDistribution: Probability distribution of classes P(C_i)
        - classLists: Instances are divided into K lists, where each list contains only instances from a single class
     */
    private func trainDiscreteVersion(priorDistribution: DiscreteDistribution, classLists: Partition) {
        var classAttributeDistributions : [String : [DiscreteDistribution]] = [:]
        for i in 0..<classLists.size() {
            classAttributeDistributions[(classLists.get(index: i) as! InstanceListOfSameClass).getClassLabel()] =  classLists.get(index: i).allAttributesDistribution()
        }
        model = NaiveBayesModel(priorDistribution: priorDistribution, classAttributeDistributions: classAttributeDistributions)
    }
    
    /**
     * Training algorithm for Naive Bayes algorithm. It basically calls trainContinuousVersion for continuous data sets,
     * trainDiscreteVersion for discrete data sets.
     - Parameters:
        - trainSet: Training data given to the algorithm
        - parameters: -
     */
    public override func train(trainSet: InstanceList, parameters: Parameter) {
        let priorDistribution = trainSet.classDistribution()
        let classLists = Partition(instanceList: trainSet)
        if classLists.get(index: 0).get(index: 0).getAttribute(index: 0) is DiscreteAttribute {
            trainDiscreteVersion(priorDistribution: priorDistribution, classLists: classLists)
        } else {
            trainContinuousVersion(priorDistribution: priorDistribution, classLists: classLists)
        }
    }
}
