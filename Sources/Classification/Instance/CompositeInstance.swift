//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 11.04.2021.
//

import Foundation

public class CompositeInstance : Instance{
    
    private var possibleClassLabels: [String]
    
    /**
     * Constructor of {@link CompositeInstance} class which takes a class label as an input. It generates a new composite instance
     * with given class label.
     - Parameters:
        - classLabel: Class label of the composite instance.
     */
    public override init(classLabel: String){
        possibleClassLabels = []
        super.init(classLabel: classLabel)
    }
    
    /**
     * Constructor of {@link CompositeInstance} class which takes a class label and attributes as inputs. It generates
     * a new composite instance with given class label and attributes.
     - Parameters:
        - classLabel: Class label of the composite instance.
        - attributes: Attributes of the composite instance.
     */
    public override init(classLabel: String, attributes: [Attribute]){
        possibleClassLabels = []
        super.init(classLabel: classLabel, attributes: attributes)
    }
    
    /**
     * Constructor of {@link CompositeInstance} class which takes an {@link java.lang.reflect.Array} of possible labels as
     * input. It generates a new composite instance with given labels.
     - Parameters:
        - possibleLabels: Possible labels of the composite instance.
     */
    public init(possibleLabels: [String]){
        possibleClassLabels = possibleLabels.suffix(from: 1).map { String($0) }
        super.init(classLabel: possibleLabels[0])
    }
    
    /**
     * Constructor of {@link CompositeInstance} class which takes a class label, attributes and an {@link ArrayList} of
     * possible labels as inputs. It generates a new composite instance with given labels, attributes and possible labels.
     - Parameters:
        - classLabel:          Class label of the composite instance.
        - attributes:          Attributes of the composite instance.
        - possibleClassLabels: Possible labels of the composite instance.
     */
    public init(classLabel: String, attributes: [Attribute], possibleClassLabels: [String]){
        self.possibleClassLabels = possibleClassLabels
        super.init(classLabel: classLabel, attributes: attributes)
    }
    
    /**
     * Accessor for the possible class labels.
     *
        - Returns: Possible class labels of the composite instance.
     */
    public func getPossibleClassLabels() -> [String]{
        return possibleClassLabels
    }
    
    /**
     * Mutator method for possible class labels.
     - Parameters:
        - possibleClassLabels: Ner value of possible class labels.
     */
    public func setPossibleClassLabels(possibleClassLabels: [String]){
        self.possibleClassLabels = possibleClassLabels
    }
    
    public override func description() -> String {
        var result: String = super.description()
        for possibleClassLabel in possibleClassLabels{
            result += ";" + possibleClassLabel
        }
        return result
    }
}
