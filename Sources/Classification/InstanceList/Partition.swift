//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 13.04.2021.
//

import Foundation
import Util

public class Partition {
    
    private var multiList : [InstanceList] = []
    
    /**
     * Divides the instances in the instance list into partitions so that all instances of a class are grouped in a
     * single partition.
     - Parameters:
        - instanceList: Instance list for which partition will be created.
     */
    public init(instanceList: InstanceList){
        let classLabels : [String] = instanceList.getDistinctClassLabels()
        for classLabel in classLabels{
            add(list: InstanceListOfSameClass(classLabel: classLabel))
        }
        for instance in instanceList.getInstances() {
            get(index: classLabels.firstIndex(of: instance.getClassLabel())!).add(instance: instance)
        }
    }
    
    /**
     * Creates a stratified partition of the current instance list. In a stratified partition, the percentage of each
     * class is preserved. For example, let's say there are three classes in the instance list, and let the percentages of
     * these classes be %20, %30, and %50; then the percentages of these classes in the stratified partitions are the
     * same, that is, %20, %30, and %50.
     - Parameters:
        - instanceList: Instance list for which partition will be created.
        - ratio: Ratio of the stratified partition. Ratio is between 0 and 1. If the ratio is 0.2, then 20 percent
     *              of the instances are put in the first group, 80 percent of the instances are put in the second group.
        - stratified: If true, stratified partition is obtained.
     */
    public init(instanceList: InstanceList, ratio: Double, stratified: Bool){
        add(list: InstanceList())
        add(list: InstanceList())
        if stratified {
            let distribution = instanceList.classDistribution()
            var counts = [Int](repeating: 0, count: distribution.size())
            let randomArray : [Int] = RandomArray.indexArray(itemCount: instanceList.size())
            for i in 0..<instanceList.size() {
                let instance = instanceList.get(index: randomArray[i])
                let classIndex = distribution.getIndex(item: instance.getClassLabel())
                if Double(counts[classIndex]) < Double(instanceList.size()) * ratio * distribution.getProbability(item: instance.getClassLabel()) {
                    get(index: 0).add(instance: instance)
                } else {
                    get(index: 1).add(instance: instance)
                }
                counts[classIndex] += 1
            }
        } else {
            instanceList.shuffle()
            for i in 0..<instanceList.size() {
                let instance = instanceList.get(index: i)
                if Double(i) < Double(instanceList.size()) * ratio {
                    get(index: 0).add(instance: instance);
                } else {
                    get(index: 1).add(instance: instance);
                }
            }
        }
    }
    
    /**
     * Creates a partition depending on the distinct values of a discrete attribute. If the discrete attribute has 4
     * distinct values, the resulting partition will have 4 groups, where each group contain instance whose
     * values of that discrete attribute are the same.
     - Parameters:
        - instanceList: Instance list for which partition will be created.
        - attributeIndex: Index of the discrete attribute.
     */
    public init(instanceList: InstanceList, attributeIndex: Int){
        let valueList : [String] = instanceList.getAttributeValueList(attributeIndex: attributeIndex)
        for _ in valueList {
            add(list: InstanceList())
        }
        for instance in instanceList.getInstances() {
            get(index: valueList.firstIndex(of: (instance.getAttribute(index: attributeIndex) as! DiscreteAttribute).getValue())!).add(instance: instance)
        }
    }
    
    /**
     * Creates a partition depending on the distinct values of a discrete indexed attribute.
     - Parameters:
        - instanceList: Instance list for which partition will be created.
        - attributeIndex: Index of the discrete indexed attribute.
        - attributeValue: Value of the attribute.
     */
    public init(instanceList: InstanceList, attributeIndex: Int, attributeValue: Int){
        add(list: InstanceList())
        add(list: InstanceList())
        for instance in instanceList.getInstances() {
            if (instance.getAttribute(index: attributeIndex) as! DiscreteIndexedAttribute).getIndex() == attributeValue {
                get(index: 0).add(instance: instance)
            } else {
                get(index: 1).add(instance: instance)
            }
        }
    }
    
    /**
     * Creates a two group partition depending on the values of a continuous attribute. If the value of the attribute is
     * less than splitValue, the instance is forwarded to the first group, else it is forwarded to the second group.
     - Parameters:
        - instanceList: Instance list for which partition will be created.
        - attributeIndex: Index of the continuous attribute
        - splitValue:     Threshold to divide instances
     */
    public init(instanceList: InstanceList, attributeIndex: Int, splitValue: Double){
        add(list: InstanceList())
        add(list: InstanceList())
        for instance in instanceList.getInstances() {
            if (instance.getAttribute(index: attributeIndex) as! ContinuousAttribute).getValue() <= splitValue {
                get(index: 0).add(instance: instance)
            } else {
                get(index: 1).add(instance: instance)
            }
        }
    }
    
    /**
     * Adds given instance list to the list of instance lists.
     - Parameters:
        - list: Instance list to add.
     */
    public func add(list: InstanceList){
        multiList.append(list)
    }
    
    /**
     * Returns the size of the list of instance lists.
     *
        - Returns: The size of the list of instance lists.
     */
    public func size() -> Int{
        return multiList.count
    }
    
    /**
     * Returns the corresponding instance list at given index of list of instance lists.
     - Parameters:
        - index: Index of the instance list.
     - Returns: Instance list at given index of list of instance lists.
     */
    public func get(index: Int) -> InstanceList{
        return multiList[index]
    }
    
    /**
     * Returns the instances of the items at the list of instance lists.
     *
        - Returns: Instances of the items at the list of instance lists.
     */
    public func getLists() -> [[Instance]]{
        var result : [[Instance]] = []
        for i in 0..<multiList.count{
            result.append(multiList[i].getInstances())
        }
        return result
    }
}
