//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation

public class Knn : Classifier{
    
    /**
     * Training algorithm for K-nearest neighbor classifier.
     - Parameters:
        - trainSet:   Training data given to the algorithm.
        - parameters :  k parameter of the K-nearest neighbor algorithm
     *                   distanceMetric: distance metric used to calculate the distance between two instances.
     */
    public override func train(trainSet: InstanceList, parameters: Parameter) {
        model = KnnModel(data: trainSet, k: (parameters as! KnnParameter).getK(), distanceMetric: ( parameters as! KnnParameter).getDistanceMetric())
    }
}
