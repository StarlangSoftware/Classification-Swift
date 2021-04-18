//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation
import Math

public class NaiveBayesModel : GaussianModel{
    
    private var classMeans : [String : Vector]? = nil
    private var classDeviations : [String : Vector]? = nil
    private var classAttributeDistributions : [String : [DiscreteDistribution]]? = nil
    
    /**
     * A constructor that sets the priorDistribution, classMeans and classDeviations.
     - Parameters:
        - priorDistribution: {@link DiscreteDistribution} input.
        - classMeans:        A {@link HashMap} of String and {@link Vector}.
        - classDeviations:   A {@link HashMap} of String and {@link Vector}.
     */
    public init(priorDistribution : DiscreteDistribution, classMeans : [String : Vector], classDeviations : [String : Vector]){
        self.classMeans = classMeans
        self.classDeviations = classDeviations
        super.init()
        self.priorDistribution = priorDistribution
    }
    
    /**
     * A constructor that sets the priorDistribution and classAttributeDistributions.
     - Parameters:
        - priorDistribution:           {@link DiscreteDistribution} input.
        - classAttributeDistributions: {@link HashMap} of String and {@link ArrayList} of {@link DiscreteDistribution}s.
     */
    public init(priorDistribution: DiscreteDistribution, classAttributeDistributions: [String : [DiscreteDistribution]]) {
        self.classAttributeDistributions = classAttributeDistributions
        super.init()
        self.priorDistribution = priorDistribution
    }
    
    /**
     * The calculateMetric method takes an {@link Instance} and a String as inputs and it returns the log likelihood of
     * these inputs.
     - Parameters:
        - instance: {@link Instance} input.
        - Ci:       String input.
     - Returns: The log likelihood of inputs.
     */
    public override func calculateMetric(instance: Instance, Ci: String) -> Double {
        if classAttributeDistributions == nil {
            return logLikelihoodContinuous(classLabel: Ci, instance: instance)
        } else {
            return logLikelihoodDiscrete(classLabel: Ci, instance: instance)
        }
    }
    
    /**
     * The logLikelihoodContinuous method takes an {@link Instance} and a class label as inputs. First it gets the logarithm
     * of given class label's probability via prior distribution as logLikelihood. Then it loops times of given instance attribute size, and accumulates the
     * logLikelihood by calculating -0.5 * ((xi - mi) / si )** 2).
     - Parameters:
        - classLabel: String input class label.
        - instance:   {@link Instance} input.
     - Returns: The log likelihood of given class label and {@link Instance}.
     */
    private func logLikelihoodContinuous(classLabel: String, instance: Instance) -> Double{
        var logLikelihood : Double = log(priorDistribution.getProbability(item: classLabel))
        for i in 0..<instance.attributeSize() {
            let xi = (instance.getAttribute(index: i) as! ContinuousAttribute).getValue()
            let mi = classMeans![classLabel]!.getValue(index: i)
            let si = classDeviations![classLabel]!.getValue(index: i)
            if si != 0 {
                logLikelihood += -0.5 * pow((xi - mi) / si, 2)
            }
        }
        return logLikelihood
    }
    
    /**
     * The logLikelihoodDiscrete method takes an {@link Instance} and a class label as inputs. First it gets the logarithm
     * of given class label's probability via prior distribution as logLikelihood and gets the class attribute distribution of given class label.
     * Then it loops times of given instance attribute size, and accumulates the logLikelihood by calculating the logarithm of
     * corresponding attribute distribution's smoothed probability by using laplace smoothing on xi.
     - Parameters:
        - classLabel: String input class label.
        - instance:   {@link Instance} input.
     - Returns: The log likelihood of given class label and {@link Instance}.
     */
    private func logLikelihoodDiscrete(classLabel: String, instance: Instance) -> Double{
        var logLikelihood : Double = log(priorDistribution.getProbability(item: classLabel))
        let attributeDistributions : [DiscreteDistribution] = classAttributeDistributions![classLabel]!
        for i in 0..<instance.attributeSize() {
            let xi = (instance.getAttribute(index: i) as! DiscreteAttribute).getValue()
            logLikelihood += log(attributeDistributions[i].getProbabilityLaplaceSmoothing(item: xi))
        }
        return logLikelihood
    }
}
