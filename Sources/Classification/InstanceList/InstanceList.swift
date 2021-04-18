//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 11.04.2021.
//

import Foundation
import Sampling
import Math

public class InstanceList {
    public var list : [Instance]
    
    /**
     * Empty constructor for an instance list. Initializes the instance list with zero instances.
     */
    public init(){
        list = []
    }
    
    /**
     * Constructor for an instance list with a given data definition, data file and a separator character. Each instance
     * must be stored in a separate line separated with the character separator. The last item must be the class label.
     * The function reads the file line by line and for each line; depending on the data definition, that is, type of
     * the attributes, adds discrete and continuous attributes to a new instance. For example, given the data set file
     * <p>
     * red;1;0.4;true
     * green;-1;0.8;true
     * blue;3;1.3;false
     * <p>
     * where the first attribute is a discrete attribute, second and third attributes are continuous attributes, the
     * fourth item is the class label.
     - Parameters:
        - definition: Data definition of the data set.
        - separator:  Separator character which separates the attribute values in the data file.
        - fileName:   Name of the data set file.
     */
    public init(definition: DataDefinition, separator: Character, fileName: String){
        list = []
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let url = thisDirectory.appendingPathComponent(fileName)
        do{
            let fileContent = try String(contentsOf: url, encoding: .utf8)
            let lines : [String] = fileContent.split(whereSeparator: \.isNewline).map(String.init)
            for line in lines{
                let attributeList : [String] = line.split(separator: separator).map(String.init)
                if attributeList.count == definition.attributeCount() + 1 {
                    let current = Instance(classLabel: attributeList[attributeList.count - 1])
                    for i in 0..<attributeList.count - 1{
                        switch definition.getAttributeType(index: i) {
                            case AttributeType.DISCRETE:
                                current.addAttribute(attribute: DiscreteAttribute(value: attributeList[i]))
                            case AttributeType.BINARY:
                                current.addAttribute(attribute: BinaryAttribute(value: Bool(attributeList[i])!))
                            case AttributeType.CONTINUOUS:
                                current.addAttribute(attribute: ContinuousAttribute(value: Double(attributeList[i])!))
                            default:
                                break
                        }
                    }
                    list.append(current)
                }
            }
        }catch{
        }
    }
    
    /**
     * Empty constructor for an instance list. Initializes the instance list with the given instance list.
     - Parameters:
        - list: New list for the list variable.
     */
    public init(list: [Instance]){
        self.list = list
    }
    
    /**
     * Adds instance to the instance list.
     - Parameters:
        - instance: Instance to be added.
     */
    public func add(instance: Instance){
        list.append(instance)
    }
    
    /**
     * Adds a list of instances to the current instance list.
     - Parameters:
        - instanceList: List of instances to be added.
     */
    public func addAll(instanceList: [Instance]){
        list.append(contentsOf: instanceList)
    }
    
    /**
     * Returns size of the instance list.
     - Returns: Size of the instance list.
     */
    public func size() -> Int{
        return list.count
    }
    
    /**
     * Accessor for a single instance with the given index.
     - Parameters:
        - index: Index of the instance.
     - Returns: Instance with index 'index'.
     */
    public func get(index: Int) -> Instance{
        return list[index]
    }
    
    /**
     * Sorts instance list.
     */
    public func sort(){
        list.sort(by: {$0.getClassLabel() <= $1.getClassLabel()})
    }
    
    /**
     * Sorts instance list according to the attribute with index 'attributeIndex'.
     *
     * @param attributeIndex index of the attribute.
     */
    public func sort(attributeIndex: Int){
        list.sort(by: {($0.getAttribute(index: attributeIndex) as! ContinuousAttribute).getValue() <= ($1.getAttribute(index: attributeIndex) as! ContinuousAttribute).getValue()})
    }
    
    /**
     * Shuffles the instance list.
     - Parameters:
        - seed: Seed is used for random number generation.
     */
    public func shuffle(){
        list.shuffle()
    }
    
    /**
     * Creates a bootstrap sample from the current instance list.
     - Parameters:
        - seed: To create a different bootstrap sample, we need a new seed for each sample.
     - Returns: Bootstrap sample.
     */
    public func bootstrap(seed: Int) -> Bootstrap<Instance>{
        return Bootstrap<Instance>(instanceList: list, seed: seed)
    }
    
    /**
     * Extracts the class labels of each instance in the instance list and returns them in an array of {@link String}.
     *
        - Returns: An array list of class labels.
     */
    public func getClassLabels() -> [String] {
        var classLabels : [String] = []
        for instance in list{
            classLabels.append(instance.getClassLabel())
        }
        return classLabels
    }
    
    /**
     * Extracts the class labels of each instance in the instance list and returns them as a set.
     *
        - Returns: An {@link ArrayList} of distinct class labels.
     */
    public func getDistinctClassLabels() -> [String] {
        var classLabels : [String] = []
        for instance in list{
            if !classLabels.contains(instance.getClassLabel()){
                classLabels.append(instance.getClassLabel())
            }
        }
        return classLabels
    }
    
    /**
     * Extracts the possible class labels of each instance in the instance list and returns them as a set.
     *
        - Returns: An {@link ArrayList} of distinct class labels.
     */
    public func getUnionOfPossibleClassLabels() -> [String] {
        var possibleClassLabels: [String] = []
        for instance in list{
            if instance is CompositeInstance{
                let compositeInstance = instance as! CompositeInstance
                for possibleClassLabel in compositeInstance.getPossibleClassLabels(){
                    if !possibleClassLabels.contains(possibleClassLabel){
                        possibleClassLabels.append(possibleClassLabel)
                    }
                }
            } else {
                if !possibleClassLabels.contains(instance.getClassLabel()){
                    possibleClassLabels.append(instance.getClassLabel())
                }
            }
        }
        return possibleClassLabels
    }
    
    /**
     * Extracts distinct discrete values of a given attribute as an array of strings.
     - Parameters:
        - attributeIndex: Index of the discrete attribute.
     - Returns: An array of distinct values of a discrete attribute.
     */
    public func getAttributeValueList(attributeIndex: Int) -> [String]{
        var valueList : [String] = []
        for instance in list{
            if !valueList.contains((instance.getAttribute(index: attributeIndex) as! DiscreteAttribute).getValue()){
                valueList.append((instance.getAttribute(index: attributeIndex) as! DiscreteAttribute).getValue())
            }
        }
        return valueList
    }
    
    /**
     * Calculates the mean of a single attribute for this instance list (m_i). If the attribute is discrete, the maximum
     * occurring value for that attribute is returned. If the attribute is continuous, the mean value of the values of
     * all instances are returned.
     - Parameters:
        - index: Index of the attribute.
     - Returns: The mean value of the instances as an attribute.
     */
    private func attributeAverage(index: Int) -> Attribute?{
        if list[0].getAttribute(index: index) is DiscreteAttribute {
            var values : [String] = []
            for instance in list {
                values.append((instance.getAttribute(index: index) as! DiscreteAttribute).getValue())
            }
            return DiscreteAttribute(value: Model.getMaximum(classLabels: values))
        } else {
            if list[0].getAttribute(index: index) is ContinuousAttribute {
                var sum : Double = 0.0
                for instance in list {
                    sum += (instance.getAttribute(index: index) as! ContinuousAttribute).getValue()
                }
                return ContinuousAttribute(value: sum / Double(list.count))
            } else {
                return nil
            }
        }
    }
    
    /**
     * Calculates the mean of a single attribute for this instance list (m_i).
     - Parameters:
        - index: Index of the attribute.
     - Returns: The mean value of the instances as an attribute.
     */
    private func continuousAttributeAverage(index: Int) -> [Double]?{
        if list[0].getAttribute(index: index) is DiscreteIndexedAttribute {
            let maxIndexSize = (list[0].getAttribute(index: index) as! DiscreteIndexedAttribute).getMaxIndex()
            var values : [Double] = []
            for _ in 0..<maxIndexSize {
                values.append(0.0)
            }
            for instance in list {
                let valueIndex = (instance.getAttribute(index: index) as! DiscreteIndexedAttribute).getIndex()
                values[valueIndex] += 1
            }
            for i in 0..<values.count {
                values[i] /= Double(list.count)
            }
            return values
        } else {
            if list[0].getAttribute(index: index) is ContinuousAttribute {
                var sum : Double = 0.0
                for instance in list {
                    sum += (instance.getAttribute(index: index) as! ContinuousAttribute).getValue()
                }
                var values : [Double] = []
                values.append(sum / Double(list.count))
                return values
            } else {
                return nil
            }
        }
    }
    
    /**
     * Calculates the standard deviation of a single attribute for this instance list (m_i). If the attribute is discrete,
     * null returned. If the attribute is continuous, the standard deviation  of the values all instances are returned.
     - Parameters:
        - index: Index of the attribute.
     - Returns: The standard deviation of the instances as an attribute.
     */
    private func attributeStandardDeviation(index: Int) -> Attribute?{
        if list[0].getAttribute(index: index) is ContinuousAttribute {
            var sum : Double = 0.0
            for instance in list {
                sum += (instance.getAttribute(index: index) as! ContinuousAttribute).getValue()
            }
            let average = sum / Double(list.count)
            sum = 0.0
            for instance in list {
                sum += pow((instance.getAttribute(index: index) as! ContinuousAttribute).getValue() - average, 2)
            }
            return ContinuousAttribute(value: sqrt(sum / Double((list.count - 1))))
        } else {
            return nil
        }
    }
    
    /**
     * Calculates the standard deviation of a single continuous attribute for this instance list (m_i).
     - Parameters:
        - index: Index of the attribute.
     - Returns: The standard deviation of the instances as an attribute.
     */
    private func continuousAttributeStandardDeviation(index: Int) -> [Double]?{
        if list[0].getAttribute(index: index) is DiscreteIndexedAttribute {
            let maxIndexSize = (list[0].getAttribute(index: index) as! DiscreteIndexedAttribute).getMaxIndex()
            var averages : [Double] = []
            for _ in 0..<maxIndexSize {
                averages.append(0.0)
            }
            for instance in list {
                let valueIndex = (instance.getAttribute(index: index) as! DiscreteIndexedAttribute).getIndex()
                averages[valueIndex] += 1
            }
            for i in 0..<averages.count {
                averages[i] /= Double(list.count)
            }
            var values : [Double] = []
            for _ in 0..<maxIndexSize {
                values.append(0.0)
            }
            for instance in list {
                let valueIndex = (instance.getAttribute(index: index) as! DiscreteIndexedAttribute).getIndex()
                for i in 0..<maxIndexSize {
                    if i == valueIndex {
                        values[i] += pow(1 - averages[i], 2)
                    } else {
                        values[i] += pow(averages[i], 2)
                    }
                }
            }
            for i in 0..<values.count {
                values[i] = sqrt(values[i] / Double((list.count - 1)))
            }
            return values
        } else {
            if list[0].getAttribute(index: index) is ContinuousAttribute {
                var sum : Double = 0.0
                for instance in list {
                    sum += (instance.getAttribute(index: index) as! ContinuousAttribute).getValue()
                }
                let average = sum / Double(list.count)
                sum = 0.0
                for instance in list {
                    sum += pow((instance.getAttribute(index: index) as! ContinuousAttribute).getValue() - average, 2)
                }
                var result : [Double] = []
                result.append(sqrt(sum / Double((list.count - 1))))
                return result
            } else {
                return nil
            }
        }
    }
    
    /**
     * The attributeDistribution method takes an index as an input and if the attribute of the instance at given index is
     * discrete, it returns the distribution of the attributes of that instance.
     - Parameters:
        - index: Index of the attribute.
     - Returns: Distribution of the attribute.
     */
    public func attributeDistribution(index: Int) -> DiscreteDistribution{
        let distribution = DiscreteDistribution()
        if list[0].getAttribute(index: index) is DiscreteAttribute {
            for instance in list {
                distribution.addItem(item: (instance.getAttribute(index: index) as! DiscreteAttribute).getValue())
            }
        }
        return distribution
    }
    
    /**
     * The attributeClassDistribution method takes an attribute index as an input. It loops through the instances, gets
     * the corresponding value of given attribute index and adds the class label of that instance to the discrete distributions list.
     - Parameters:
        - attributeIndex: Index of the attribute.
     - Returns: Distribution of the class labels.
     */
    public func attributeClassDistribution(attributeIndex: Int) -> [DiscreteDistribution] {
        var distributions : [DiscreteDistribution] = []
        let valueList : [String] = getAttributeValueList(attributeIndex: attributeIndex)
        for _ in valueList {
            distributions.append(DiscreteDistribution())
        }
        for instance in list {
            distributions[valueList.firstIndex(of: (instance.getAttribute(index: attributeIndex) as! DiscreteAttribute).getValue())!].addItem(item: instance.getClassLabel())
        }
        return distributions
    }
    
    /**
     * The discreteIndexedAttributeClassDistribution method takes an attribute index and an attribute value as inputs.
     * It loops through the instances, gets the corresponding value of given attribute index and given attribute value.
     * Then, adds the class label of that instance to the discrete indexed distributions list.
     - Parameters:
        - attributeIndex: Index of the attribute.
        - attributeValue: Value of the attribute.
     - Returns: Distribution of the class labels.
     */
    public func discreteIndexedAttributeClassDistribution(attributeIndex: Int, attributeValue: Int) -> DiscreteDistribution{
        let distribution = DiscreteDistribution()
        for instance in list {
            if ((instance.getAttribute(index: attributeIndex) as! DiscreteIndexedAttribute).getIndex() == attributeValue) {
                distribution.addItem(item: instance.getClassLabel())
            }
        }
        return distribution
    }
    
    /**
     * The classDistribution method returns the distribution of all the class labels of instances.
     *
        - Returns: Distribution of the class labels.
     */
    public func classDistribution() -> DiscreteDistribution{
        let distribution = DiscreteDistribution()
        for instance in list {
            distribution.addItem(item: instance.getClassLabel())
        }
        return distribution
    }
    
    /**
     * The allAttributesDistribution method returns the distributions of all the attributes of instances.
     *
        - Returns: Distributions of all the attributes of instances.
     */
    public func allAttributesDistribution() -> [DiscreteDistribution]{
        var distributions : [DiscreteDistribution] = []
        for i in 0..<list[0].attributeSize() {
            distributions.append(attributeDistribution(index: i))
        }
        return distributions
    }
    
    /**
     * Returns the mean of all the attributes for instances in the list.
     *
        - Returns: Mean of all the attributes for instances in the list.
     */
    public func average() -> Instance{
        let result = Instance(classLabel: list[0].getClassLabel())
        for i in 0..<list[0].attributeSize() {
            result.addAttribute(attribute: attributeAverage(index: i)!)
        }
        return result
    }
    
    /**
     * Calculates mean of the attributes of instances.
     *
        - Returns: Mean of the attributes of instances.
     */
    public func continuousAttributeAverage() -> [Double]{
        var result : [Double] = []
        for i in 0..<list[0].attributeSize() {
            result.append(contentsOf: continuousAttributeAverage(index: i)!)
        }
        return result
    }
    
    /**
     * Returns the standard deviation of attributes for instances.
     *
        - Returns: Standard deviation of attributes for instances.
     */
    public func standardDeviation() -> Instance{
        let result = Instance(classLabel: list[0].getClassLabel())
        for i in 0..<list[0].attributeSize() {
            result.addAttribute(attribute: attributeStandardDeviation(index: i)!)
        }
        return result
    }
    
    /**
     * Returns the standard deviation of continuous attributes for instances.
     *
        - Returns: Standard deviation of continuous attributes for instances.
     */
    public func continuousAttributeStandardDeviation() -> [Double]{
        var result : [Double] = []
        for i in 0..<list[0].attributeSize() {
            result.append(contentsOf: continuousAttributeStandardDeviation(index: i)!)
        }
        return result
    }
    
    /**
     * Calculates a covariance {@link Matrix} by using an average {@link Vector}.
     - Parameters:
        - average: Vector input.
     - Returns: Covariance {@link Matrix}.
     */
    public func covariance(average: Vector) -> Matrix{
        let result = Matrix(row: list[0].continuousAttributeSize(), col: list[0].continuousAttributeSize())
        for instance in list {
            let continuousAttributes : [Double] = instance.continuousAttributes()
            for i in 0..<instance.continuousAttributeSize() {
                let xi = continuousAttributes[i]
                let mi = average.getValue(index: i)
                for j in 0..<instance.continuousAttributeSize() {
                    let xj = continuousAttributes[j]
                    let mj = average.getValue(index: j)
                    result.addValue(rowNo: i, colNo: j, value: (xi - mi) * (xj - mj))
                }
            }
        }
        result.divideByConstant(constant: Double(list.count - 1))
        return result;
    }
    
    /**
     * Accessor for the instances.
     *
        - Returns: Instances.
     */
    public func getInstances() -> [Instance]{
        return list
    }
}
