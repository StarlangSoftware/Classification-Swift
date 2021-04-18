//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation

public class KMeans : Classifier{
    
    /**
     * Training algorithm for K-Means classifier. K-Means finds the mean of each class for training.
     - Parameters:
        - trainSet:   Training data given to the algorithm.
        - parameters: distanceMetric: distance metric used to calculate the distance between two instances.
     */
    public override func train(trainSet: InstanceList, parameters: Parameter) {
        let priorDistribution = trainSet.classDistribution()
        let classMeans = InstanceList()
        let classLists = Partition(instanceList: trainSet)
        for i in 0..<classLists.size() {
            classMeans.add(instance: classLists.get(index: i).average())
        }
        model = KMeansModel(priorDistribution: priorDistribution, classMeans: classMeans, distanceMetric: (parameters as! KMeansParameter).getDistanceMetric())
    }
}
