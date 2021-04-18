//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 13.04.2021.
//

import Foundation

public class DataSet{
    
    private var instances: InstanceList
    private var definition: DataDefinition? = nil
    
    /**
     * Constructor for generating a new {@link DataSet}.
     */
    public init(){
        instances = InstanceList()
    }
    
    /**
     * Constructor for generating a new {@link DataSet} with given {@link DataDefinition}.
     - Parameters:
        - definition: Data definition of the data set.
     */
    public init(definition: DataDefinition){
        self.definition = definition
        instances = InstanceList()
    }
    
    /**
     * Constructor for generating a new {@link DataSet} with a {@link DataDefinition}, from a {@link File} by using a separator.
     - Parameters:
        - definition: Data definition of the data set.
        - separator:  Separator character which separates the attribute values in the data file.
        - fileName:   Name of the data set file.
     */
    public init(definition: DataDefinition, separator: Character, fileName: String){
        self.definition = definition
        instances = InstanceList(definition: definition, separator: separator, fileName: fileName)
    }
    
    /**
     * Checks the correctness of the attribute type, for instance, if the attribute of given instance is a Binary attribute,
     * and the attribute type of the corresponding item of the data definition is also a Binary attribute, it then
     * returns true, and false otherwise.
     - Parameters:
        - instance: {@link Instance} to checks the attribute type.
     - Returns: true if attribute types of given {@link Instance} and data definition matches.
     */
    public func checkDefinition(instance: Instance) -> Bool{
        for i in 0..<instance.attributeSize() {
            if instance.getAttribute(index: i) is BinaryAttribute{
                if definition?.getAttributeType(index: i) != AttributeType.BINARY{
                    return false
                }
            } else {
                if instance.getAttribute(index: i) is DiscreteIndexedAttribute{
                    if definition?.getAttributeType(index: i) != AttributeType.DISCRETE_INDEXED{
                        return false
                    }
                } else {
                    if instance.getAttribute(index: i) is DiscreteAttribute{
                        if definition?.getAttributeType(index: i) != AttributeType.DISCRETE{
                            return false
                        }
                    } else {
                        if instance.getAttribute(index: i) is ContinuousAttribute{
                            if definition?.getAttributeType(index: i) != AttributeType.CONTINUOUS{
                                return false
                            }
                        }
                    }
                }
            }
        }
        return true
    }
    
    /**
     * Adds the attribute types according to given {@link Instance}. For instance, if the attribute type of given {@link Instance}
     * is a Discrete type, it than adds a discrete attribute type to the list of attribute types.
     - Parameters:
        - instance: {@link Instance} input.
     */
    public func setDefinition(instance: Instance){
        var attributeTypes : [AttributeType] = []
        for i in 0..<instance.attributeSize(){
            if instance.getAttribute(index: i) is BinaryAttribute{
                attributeTypes.append(AttributeType.BINARY)
            } else {
                if instance.getAttribute(index: i) is DiscreteIndexedAttribute{
                    attributeTypes.append(AttributeType.DISCRETE_INDEXED)
                } else {
                    if instance.getAttribute(index: i) is DiscreteAttribute{
                        attributeTypes.append(AttributeType.DISCRETE)
                    } else {
                        if instance.getAttribute(index: i) is ContinuousAttribute{
                            attributeTypes.append(AttributeType.CONTINUOUS)
                        }
                    }
                }
            }
        }
        definition = DataDefinition(attributeTypes: attributeTypes)
    }
    
    /**
     * Returns the size of the {@link InstanceList}.
     *
        - Returns: Size of the {@link InstanceList}.
     */
    public func sampleSize() -> Int{
        return instances.size()
    }
    
    /**
     * Returns the size of the class label distribution of {@link InstanceList}.
     *
        - Returns: Size of the class label distribution of {@link InstanceList}.
     */
    public func classCount() -> Int{
        return instances.classDistribution().size()
    }
    
    /**
     * Returns the number of attribute types at {@link DataDefinition} list.
     *
        - Returns: The number of attribute types at {@link DataDefinition} list.
     */
    public func attributeCount() -> Int{
        return (definition?.attributeCount())!
    }
    
    /**
     * Returns the number of discrete attribute types at {@link DataDefinition} list.
     *
        - Returns: The number of discrete attribute types at {@link DataDefinition} list.
     */
    public func discreteAttributeCount() -> Int{
        return (definition?.discreteAttributeCount())!
    }
    
    /**
     * Returns the number of continuous attribute types at {@link DataDefinition} list.
     *
        - Returns: The number of continuous attribute types at {@link DataDefinition} list.
     */
    public func continuousAttributeCount() -> Int{
        return (definition?.continuousAttributeCount())!
    }
    
    /**
     * Returns the accumulated {@link String} of class labels of the {@link InstanceList}.
     *
     * @return The accumulated {@link String} of class labels of the {@link InstanceList}.
     */
    public func getClasses() -> String{
        let classLabels = instances.getDistinctClassLabels()
        var result : String = classLabels[0]
        for i in 1..<classLabels.count {
            result += ";" + classLabels[i]
        }
        return result
    }
    
    /**
     * Adds a new instance to the {@link InstanceList}.
     - Parameters:
        - current: {@link Instance} to add.
     */
    public func addInstance(current: Instance){
        if definition == nil{
            setDefinition(instance: current)
            instances.add(instance: current)
        } else {
            if checkDefinition(instance: current){
                instances.add(instance: current)
            }
        }
    }
    
    /**
     * Adds all the instances of given instance list to the {@link InstanceList}.
     - Parameters:
        - instanceList: {@link InstanceList} to add instances from.
     */
    public func addInstanceList(instanceList: [Instance]){
        for instance in instanceList{
            addInstance(current: instance)
        }
    }
    
    /**
     * Returns the instances of {@link InstanceList}.
     *
        - Returns: The instances of {@link InstanceList}.
     */
    public func getInstances() -> [Instance]{
        return instances.getInstances()
    }
    
    /**
     * Returns instances of the items at the list of instance lists from the partitions.
     *
        - Returns: Instances of the items at the list of instance lists from the partitions.
     */
    public func getClassInstances() -> [[Instance]]{
        return Partition(instanceList: instances).getLists()
    }
    
    /**
     * Accessor for the {@link InstanceList}.
     *
        - Returns: The {@link InstanceList}.
     */
    public func getInstanceList() -> InstanceList{
        return instances
    }
    
    /**
     * Accessor for the data definition.
     *
        - Returns: The data definition.
     */
    public func getDataDefinition() -> DataDefinition{
        return definition!
    }
}
