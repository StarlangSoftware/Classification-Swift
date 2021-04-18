//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation
import Math

public class Qda : Classifier{
    
    /**
     * Training algorithm for the quadratic discriminant analysis classifier (Introduction to Machine Learning, Alpaydin, 2015).
     - Parameters:
        - trainSet:   Training data given to the algorithm.
        - parameters: -
     */
    public override func train(trainSet: InstanceList, parameters: Parameter) {
        var w0 : [String : Double] = [:]
        var w : [String : Vector] = [:]
        var W : [String : Matrix] = [:]
        let classLists = Partition(instanceList: trainSet)
        let priorDistribution = trainSet.classDistribution()
        for i in 0..<classLists.size() {
            let Ci = (classLists.get(index: i) as! InstanceListOfSameClass).getClassLabel()
            let averageVector = Vector(values: classLists.get(index: i).continuousAttributeAverage())
            let classCovariance = classLists.get(index: i).covariance(average: averageVector)
            let determinant = classCovariance.determinant()
            classCovariance.inverse()
            let Wi = classCovariance.copy() as! Matrix
            Wi.multiplyWithConstant(constant: -0.5)
            W[Ci] = Wi
            let wi = classCovariance.multiplyWithVectorFromLeft(v: averageVector)
            w[Ci] = wi
            let w0i = -0.5 * (wi.dotProduct(v: averageVector) + log(determinant)) + log(priorDistribution.getProbability(item: Ci))
            w0[Ci] = w0i
        }
        model = QdaModel(priorDistribution: priorDistribution, W: W, w: w, w0: w0)
    }
}
