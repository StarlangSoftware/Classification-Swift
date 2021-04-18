//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation
import Math

public class Lda : Classifier{
    
    /**
     * Training algorithm for the linear discriminant analysis classifier (Introduction to Machine Learning, Alpaydin, 2015).
     - Parameters:
        - trainSet:   Training data given to the algorithm.
        - parameters: -
     */
    public override func train(trainSet: InstanceList, parameters: Parameter) {
        var w0 : [String : Double] = [:]
        var w : [String : Vector] = [:]
        let priorDistribution = trainSet.classDistribution()
        let classLists = Partition(instanceList: trainSet)
        let covariance = Matrix(row: trainSet.get(index: 0).continuousAttributeSize(), col: trainSet.get(index: 0).continuousAttributeSize())
        for i in 0..<classLists.size() {
            let averageVector = Vector(values: classLists.get(index: i).continuousAttributeAverage())
            let classCovariance = classLists.get(index: i).covariance(average: averageVector)
            classCovariance.multiplyWithConstant(constant: Double(classLists.get(index: i).size() - 1))
            covariance.add(m: classCovariance)
        }
        covariance.divideByConstant(constant: Double(trainSet.size() - classLists.size()))
        covariance.inverse();
        for i in 0..<classLists.size() {
            let Ci = (classLists.get(index: i) as! InstanceListOfSameClass).getClassLabel()
            let averageVector = Vector(values: classLists.get(index: i).continuousAttributeAverage())
            let wi = covariance.multiplyWithVectorFromRight(v: averageVector)
            w[Ci] = wi
            let w0i = -0.5 * wi.dotProduct(v: averageVector) + log(priorDistribution.getProbability(item: Ci))
            w0[Ci] = w0i
        }
        model = LdaModel(priorDistribution: priorDistribution, w: w, w0: w0)
    }
}
