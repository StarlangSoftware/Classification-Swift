//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.04.2021.
//

import Foundation
import Math
import Util

public class NeuralNetworkModel : ValidatedModel{
    
    public var classLabels : [String]
    public var K, d : Int
    public var x: Vector = Vector(values: [])
    public var y: Vector = Vector(values: [])
    public var r: Vector = Vector(values: [])

    public func calculateOutput(){
        
    }
    
    /**
     * Constructor that sets the class labels, their sizes as K and the size of the continuous attributes as d.
     - Parameters:
        - trainSet: {@link InstanceList} to use as train set.
     */
    public init(trainSet: InstanceList){
        classLabels = trainSet.getDistinctClassLabels()
        K = classLabels.count
        d = trainSet.get(index: 0).continuousAttributeSize()
    }
    
    /**
     * The allocateLayerWeights method returns a new {@link Matrix} with random weights.
     - Parameters:
        - row :   Number of rows.
        - column: Number of columns.
     - Returns: Matrix with random weights.
     */
    public func allocateLayerWeights(row: Int, column: Int, random: Random) -> Matrix{
        return Matrix(row: row, col: column, min: -0.01, max: +0.01, random: random)
    }
    
    /**
     * The normalizeOutput method takes an input {@link Vector} o, gets the result for e^o of each element of o,
     * then sums them up. At the end, divides the each e^o by the summation.
     - Parameters:
        - o: Vector to normalize.
     - Returns: Normalized vector.
     */
    public func normalizeOutput(o: Vector) -> Vector{
        var sum : Double = 0.0
        var values : [Double] = []
        for i in 0..<o.size() {
            sum += exp(o.getValue(index: i))
        }
        for i in 0..<o.size() {
            values.append(exp(o.getValue(index: i)) / sum)
        }
        return Vector(values: values)
    }
    
    /**
     * The createInputVector method takes an {@link Instance} as an input. It converts given Instance to the {@link java.util.Vector}
     * and insert 1.0 to the first element.
     - Parameters:
        - instance: Instance to insert 1.0.
     */
    public func createInputVector(instance: Instance){
        x = instance.toVector()
        x.insert(pos: 0, x: 1.0)
    }
    
    /**
     * The calculateHidden method takes a {@link Vector} input and {@link Matrix} weights, It multiplies the weights
     * Matrix with given input Vector than applies the sigmoid function and returns the result.
     - Parameters:
        - input:   Vector to multiply weights.
        - weights: Matrix is multiplied with input Vector.
     - Returns: Result of sigmoid function.
     */
    public func calculateHidden(input: Vector, weights: Matrix, activationFunction: ActivationFunction) -> Vector{
        let z = weights.multiplyWithVectorFromRight(v: input)
        switch activationFunction {
            case .SIGMOID:
                z.sigmoid()
            case .TANH:
                z.tanh()
            case .RELU:
                z.relu()
        }
        return z
    }
    
    /**
     * The calculateOneMinusHidden method takes a {@link java.util.Vector} as input. It creates a Vector of ones and
     * returns the difference between given Vector.
     - Parameters:
        - hidden: Vector to find difference.
     - Returns: Returns the difference between ones Vector and input Vector.
     */
    public func calculateOneMinusHidden(hidden: Vector) -> Vector{
        let one = Vector(size: hidden.size(), x: 1.0)
        return one.difference(v: hidden)
    }
    
    /**
     * The calculateForwardSingleHiddenLayer method takes two matrices W and V. First it multiplies W with x, then
     * multiplies V with the result of the previous multiplication.
     - Parameters:
        - W: Matrix to multiply with x.
        - V: Matrix to multiply.
     */
    public func calculateForwardSingleHiddenLayer(W: Matrix, V: Matrix, activationFunction: ActivationFunction){
        let hidden = calculateHidden(input: x, weights: W, activationFunction: activationFunction)
        let hiddenBiased = hidden.biased()
        y = V.multiplyWithVectorFromRight(v: hiddenBiased)
    }
    
    /**
     * The calculateRMinusY method creates a new {@link java.util.Vector} with given Instance, then it multiplies given
     * input Vector with given weights Matrix. After normalizing the output, it return the difference between the newly created
     * Vector and normalized output.
     - Parameters:
        - instance: Instance is used to get class labels.
        - input:    Vector to multiply weights.
        - weights:  Matrix of weights/
     - Returns: Difference between newly created Vector and normalized output.
     */
    public func calculateRMinusY(instance: Instance, input: Vector, weights: Matrix) -> Vector{
        r = Vector(size: K, index: classLabels.firstIndex(of: instance.getClassLabel())!, x: 1.0)
        let o = weights.multiplyWithVectorFromRight(v: input)
        y = normalizeOutput(o: o)
        return r.difference(v: y)
    }
    
    /**
     * The predictWithCompositeInstance method takes an ArrayList possibleClassLabels. It returns the class label
     * which has the maximum value of y.
     - Parameters:
        - possibleClassLabels: ArrayList that has the class labels.
     - Returns: The class label which has the maximum value of y.
     */
    public func predictWithCompositeInstance(possibleClassLabels: [String]) -> String{
        var predictedClass = possibleClassLabels[0]
        var maxY : Double = -Double.infinity
        for i in 0..<classLabels.count {
            if possibleClassLabels.contains(classLabels[i]) && y.getValue(index: i) > maxY {
                maxY = y.getValue(index: i)
                predictedClass = classLabels[i]
            }
        }
        return predictedClass
    }
    
    /**
     * The predict method takes an {@link Instance} as an input, converts it to a Vector and calculates the {@link Matrix} y by
     * multiplying Matrix W with {@link Vector} x. Then it returns the class label which has the maximum y value.
     - Parameters:
        - instance: Instance to predict.
     - Returns: The class label which has the maximum y.
     */
    public override func predict(instance: Instance) -> String {
        createInputVector(instance: instance)
        calculateOutput()
        if instance is CompositeInstance {
            return predictWithCompositeInstance(possibleClassLabels: (instance as! CompositeInstance).getPossibleClassLabels())
        } else {
            return classLabels[y.maxIndex()]
        }
    }
    
    public override func predictProbability(instance: Instance) -> [String : Double] {
        createInputVector(instance: instance)
        calculateOutput()
        var result : [String : Double] = [:]
        for i in 0..<classLabels.count{
            result[classLabels[i]] = y.getValue(index: i)
        }
        return result
    }
}
