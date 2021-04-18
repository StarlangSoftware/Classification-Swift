//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation
import Math

public class QdaModel : LdaModel {
    
    private var W : Dictionary<String, Matrix>
    
    /**
     * The constructor which sets the priorDistribution, w w1 and HashMap of String Matrix.
     - Parameters:
        - priorDistribution: {@link DiscreteDistribution} input.
        - W:                 {@link HashMap} of String and Matrix.
        - w:                 {@link HashMap} of String and Vectors.
        - w0:                {@link HashMap} of String and Double.
     */
    public init(priorDistribution: DiscreteDistribution, W: Dictionary<String, Matrix>, w: Dictionary<String, Vector>, w0: Dictionary<String, Double>) {
        self.W = W
        super.init(priorDistribution: priorDistribution, w: w, w0: w0)
    }
    
    /**
     * The calculateMetric method takes an {@link Instance} and a String as inputs. It multiplies Matrix Wi with Vector xi
     * then calculates the dot product of it with xi. Then, again it finds the dot product of wi and xi and returns the summation with w0i.
     - Parameters:
        - instance: {@link Instance} input.
        - Ci:       String input.
     - Returns: The result of Wi.multiplyWithVectorFromLeft(xi).dotProduct(xi) + wi.dotProduct(xi) + w0i.
     */
    public override func calculateMetric(instance: Instance, Ci: String) -> Double {
        let xi = instance.toVector()
        let Wi = W[Ci]
        let wi = w[Ci]
        let w0i = w0[Ci]
        return Wi!.multiplyWithVectorFromLeft(v: xi).dotProduct(v: xi) + wi!.dotProduct(v: xi) + w0i!
    }
}
