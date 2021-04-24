//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation
import Math

public class DummyModel : Model{
    
    private var distribution: DiscreteDistribution
    
    /**
     * Constructor which sets the distribution using the given {@link InstanceList}.
     - Parameters:
        - trainSet: {@link InstanceList} which is used to get the class distribution.
     */
    public init(trainSet: InstanceList){
        self.distribution = trainSet.classDistribution()
    }
    
    /**
     * The predict method takes an Instance as an input and returns the entry of distribution which has the maximum value.
     - Parameters:
        - instance: Instance to make prediction.
     - Returns: The entry of distribution which has the maximum value.
     */
    public override func predict(instance: Instance) -> String {
        if instance is CompositeInstance {
            let possibleClassLabels : [String] = (instance as! CompositeInstance).getPossibleClassLabels()
            return distribution.getMaxItemIncludeTheseOnly(includeTheseOnly: possibleClassLabels)
        } else {
            return distribution.getMaxItem()
        }
    }
    
    public override func predictProbability(instance: Instance) -> [String : Double] {
        return distribution.getProbabilityDistribution()
    }
}
