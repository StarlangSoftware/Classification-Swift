//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation
import Math

public class LdaModel : GaussianModel{
    
    public var w0 : Dictionary<String, Double>
    public var w : Dictionary<String, Vector>
    
    /**
     * A constructor which sets the priorDistribution, w and w0 according to given inputs.
     - Parameters:
        - priorDistribution: {@link DiscreteDistribution} input.
        - w:                 {@link HashMap} of String and Vectors.
        - w0 :               {@link HashMap} of String and Double.
     */
    public init(priorDistribution: DiscreteDistribution, w: Dictionary<String, Vector>, w0: Dictionary<String, Double>){
        self.w = w
        self.w0 = w0
        super.init()
        self.priorDistribution = priorDistribution
    }
    
    /**
     * The calculateMetric method takes an {@link Instance} and a String as inputs. It returns the dot product of given Instance
     * and wi plus w0i.
     - Parameters:
        - instance: {@link Instance} input.
        - Ci :      String input.
     - Returns: The dot product of given Instance and wi plus w0i.
     */
    public override func calculateMetric(instance: Instance, Ci: String) -> Double {
        let xi = instance.toVector()
        let wi = w[Ci]
        let w0i = w0[Ci]
        return wi!.dotProduct(v: xi) + w0i!
    }
}
