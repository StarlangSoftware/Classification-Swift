//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation
import Math
import Util

public class DecisionNode {
    
    internal var children : [DecisionNode]? = nil
    private var EPSILON : Double = 0.0000000001
    private var data : InstanceList? = nil
    private var classLabel : String? = nil
    internal var leaf : Bool = false
    private var condition : DecisionCondition? = nil
    
    public init(data: InstanceList, condition: DecisionCondition?, parameter: RandomForestParameter?, isStump: Bool){
        var size : Int
        var bestAttribute : Int = -1
        var bestSplitValue : Double = 0.0
        var previousValue : Double
        self.condition = condition
        self.data = data
        classLabel = Model.getMaximum(classLabels: data.getClassLabels())
        leaf = true
        let classLabels = data.getDistinctClassLabels()
        if classLabels.count == 1 {
            return
        }
        if isStump && condition != nil {
            return
        }
        var indexList : [Int]
        if parameter != nil && parameter!.getAttributeSubsetSize() < data.get(index: 0).attributeSize() {
            indexList = RandomArray.indexArray(itemCount: data.get(index: 0).attributeSize())
            size = parameter!.getAttributeSubsetSize()
        } else {
            indexList = []
            for i in 0..<data.get(index: 0).attributeSize() {
                indexList.append(i)
            }
            size = data.get(index: 0).attributeSize()
        }
        let classDistribution = data.classDistribution()
        var bestEntropy : Double = data.classDistribution().entropy()
        for j in 0..<size {
            let index = indexList[j]
            if data.get(index: 0).getAttribute(index: index) is DiscreteIndexedAttribute {
                for k in 0..<(data.get(index: 0).getAttribute(index: index) as! DiscreteIndexedAttribute).getMaxIndex() {
                    let distribution = data.discreteIndexedAttributeClassDistribution(attributeIndex: index, attributeValue: k)
                    if distribution.getSum() > 0 {
                        classDistribution.removeDistribution(distribution: distribution)
                        let entropy = (classDistribution.entropy() * classDistribution.getSum() + distribution.entropy() * distribution.getSum()) / Double(data.size())
                        if entropy + EPSILON < bestEntropy {
                            bestEntropy = entropy
                            bestAttribute = index
                            bestSplitValue = Double(k)
                        }
                        classDistribution.addDistribution(distribution: distribution)
                    }
                }
            } else {
                if data.get(index: 0).getAttribute(index: index) is DiscreteAttribute {
                    let entropy = entropyForDiscreteAttribute(attributeIndex: index)
                    if entropy + EPSILON < bestEntropy {
                        bestEntropy = entropy
                        bestAttribute = index;
                    }
                } else {
                    if data.get(index: 0).getAttribute(index: index) is ContinuousAttribute {
                        data.sort(attributeIndex: index);
                        previousValue = -Double.infinity
                        let leftDistribution = data.classDistribution()
                        let rightDistribution = DiscreteDistribution()
                        for k in 0..<data.size() {
                            let instance = data.get(index: k)
                            if k == 0 {
                                previousValue = (instance.getAttribute(index: index) as! ContinuousAttribute).getValue()
                            } else {
                                if (instance.getAttribute(index: index) as! ContinuousAttribute).getValue() != previousValue {
                                    let splitValue = (previousValue + (instance.getAttribute(index: index) as! ContinuousAttribute).getValue()) / 2
                                    previousValue = (instance.getAttribute(index: index) as! ContinuousAttribute).getValue()
                                    let entropy = (leftDistribution.getSum() / Double(data.size())) * leftDistribution.entropy() + (rightDistribution.getSum() / Double(data.size())) * rightDistribution.entropy()
                                    if entropy + EPSILON < bestEntropy {
                                        bestEntropy = entropy
                                        bestSplitValue = splitValue
                                        bestAttribute = index
                                    }
                                }
                            }
                            leftDistribution.removeItem(item: instance.getClassLabel())
                            rightDistribution.addItem(item: instance.getClassLabel())
                        }
                    }
                }
            }
        }
        if bestAttribute != -1 {
            leaf = false
            if data.get(index: 0).getAttribute(index: bestAttribute) is DiscreteIndexedAttribute {
                createChildrenForDiscreteIndexed(attributeIndex: bestAttribute, attributeValue: Int(bestSplitValue), parameter: parameter!, isStump: isStump)
            } else {
                if data.get(index: 0).getAttribute(index: bestAttribute) is DiscreteAttribute {
                    createChildrenForDiscrete(attributeIndex: bestAttribute, parameter: parameter!, isStump: isStump)
                } else {
                    if data.get(index: 0).getAttribute(index: bestAttribute) is ContinuousAttribute {
                        createChildrenForContinuous(attributeIndex: bestAttribute, splitValue: bestSplitValue, parameter: parameter!, isStump: isStump)
                    }
                }
            }
        }
    }
    
    /**
     * The entropyForDiscreteAttribute method takes an attributeIndex and creates an ArrayList of DiscreteDistribution.
     * Then loops through the distributions and calculates the total entropy.
     - Parameters:
        - attributeIndex: Index of the attribute.
     - Returns: Total entropy for the discrete attribute.
     */
    private func entropyForDiscreteAttribute(attributeIndex: Int) -> Double{
        var sum : Double = 0.0
        let distributions : [DiscreteDistribution] = data!.attributeClassDistribution(attributeIndex: attributeIndex)
        for distribution in distributions {
            sum += (distribution.getSum() / Double(data!.size())) * distribution.entropy()
        }
        return sum
    }
    
    /**
     * The createChildrenForDiscreteIndexed method creates an ArrayList of DecisionNodes as children and a partition with respect to
     * indexed attribute.
     - Parameters:
        - attributeIndex: Index of the attribute.
        - attributeValue: Value of the attribute.
        - parameter:      RandomForestParameter like seed, ensembleSize, attributeSubsetSize.
        - isStump:        Refers to decision trees with only 1 splitting rule.
     */
    private func createChildrenForDiscreteIndexed(attributeIndex: Int, attributeValue: Int, parameter: RandomForestParameter, isStump: Bool){
        let childrenData = Partition(instanceList: data!, attributeIndex: attributeIndex, attributeValue: attributeValue)
        children = []
        children!.append(DecisionNode(data: childrenData.get(index: 0), condition: DecisionCondition(attributeIndex: attributeIndex, value: DiscreteIndexedAttribute(value: "", index: attributeValue, maxIndex: (data!.get(index: 0).getAttribute(index: attributeIndex) as! DiscreteIndexedAttribute).getMaxIndex())), parameter: parameter, isStump: isStump))
        children!.append(DecisionNode(data: childrenData.get(index: 1), condition: DecisionCondition(attributeIndex: attributeIndex, value: DiscreteIndexedAttribute(value: "", index: -1, maxIndex: ( data!.get(index: 0).getAttribute(index: attributeIndex) as! DiscreteIndexedAttribute).getMaxIndex())), parameter: parameter, isStump: isStump))
    }
    
    /**
     * The createChildrenForDiscrete method creates an ArrayList of values, a partition with respect to attributes and an ArrayList
     * of DecisionNodes as children.
     - Parameters:
        - attributeIndex: Index of the attribute.
        - parameter:      RandomForestParameter like seed, ensembleSize, attributeSubsetSize.
        - isStump:        Refers to decision trees with only 1 splitting rule.
     */
    private func createChildrenForDiscrete(attributeIndex: Int, parameter: RandomForestParameter, isStump: Bool){
        let valueList = data!.getAttributeValueList(attributeIndex: attributeIndex)
        let childrenData = Partition(instanceList: data!, attributeIndex: attributeIndex)
        children = []
        for i in 0..<valueList.count {
            children!.append(DecisionNode(data: childrenData.get(index: i), condition: DecisionCondition(attributeIndex: attributeIndex, value: DiscreteAttribute(value: valueList[i])), parameter: parameter, isStump: isStump))
        }
    }
    
    /**
     * The createChildrenForContinuous method creates an ArrayList of DecisionNodes as children and a partition with respect to
     * continuous attribute and the given split value.
     - Parameters:
        - attributeIndex: Index of the attribute.
        - parameter:      RandomForestParameter like seed, ensembleSize, attributeSubsetSize.
        - isStump:        Refers to decision trees with only 1 splitting rule.
        - splitValue:     Split value is used for partitioning.
     */
    private func createChildrenForContinuous(attributeIndex: Int, splitValue: Double, parameter: RandomForestParameter, isStump: Bool){
        let childrenData = Partition(instanceList: data!, attributeIndex: attributeIndex, splitValue: splitValue)
        children = []
        children!.append(DecisionNode(data: childrenData.get(index: 0), condition: DecisionCondition(attributeIndex: attributeIndex, comparison: "<", value: ContinuousAttribute(value: splitValue)), parameter: parameter, isStump: isStump))
        children!.append(DecisionNode(data: childrenData.get(index: 1), condition: DecisionCondition(attributeIndex: attributeIndex, comparison: ">", value: ContinuousAttribute(value: splitValue)), parameter: parameter, isStump: isStump))
    }
    
    /**
     * The predict method takes an {@link Instance} as input and performs prediction on the DecisionNodes and returns the prediction
     * for that instance.
     - Parameters:
        - instance: Instance to make prediction.
     - Returns: The prediction for given instance.
     */
    public func predict(instance: Instance) -> String?{
        if instance is CompositeInstance {
            let possibleClassLabels : [String] = (instance as! CompositeInstance).getPossibleClassLabels()
            let distribution = data!.classDistribution()
            let predictedClass = distribution.getMaxItemIncludeTheseOnly(includeTheseOnly: possibleClassLabels)
            if leaf {
                return predictedClass
            } else {
                for node in children! {
                    if node.condition!.satisfy(instance: instance) {
                        let childPrediction = node.predict(instance: instance)
                        if childPrediction != nil {
                            return childPrediction
                        } else {
                            return predictedClass
                        }
                    }
                }
                return predictedClass
            }
        } else {
            if leaf {
                return classLabel!
            } else {
                for node in children! {
                    if node.condition!.satisfy(instance: instance) {
                        return node.predict(instance: instance)
                    }
                }
                return classLabel
            }
        }
    }

    public func predictProbabilityDistribution(instance: Instance) -> [String : Double]{
        if leaf {
            return (data?.classDistribution().getProbabilityDistribution())!
        } else {
            for node in children! {
                if node.condition!.satisfy(instance: instance) {
                    return node.predictProbabilityDistribution(instance: instance)
                }
            }
            return (data?.classDistribution().getProbabilityDistribution())!
        }
    }

}
