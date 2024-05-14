//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation
import Util

public class RandomModel : Model{
    
    private var classLabels: [String]
    private var random: Random
    
    /**
     * A constructor that sets the class labels.
     - Parameters:
        - classLabels: An ArrayList of class labels.
        - seed: Seed of the random function.
     */
    public init(classLabels: [String], seed: Int){
        self.classLabels = classLabels
        self.random = Random(seed: seed)
    }
    
    /**
     * The predict method gets an Instance as an input and retrieves the possible class labels as an ArrayList. Then selects a
     * random number as an index and returns the class label at this selected index.
     - Parameters:
        - instance: {@link Instance} to make prediction.
     - Returns: The class label at the randomly selected index.
     */
    public override func predict(instance: Instance) -> String {
        if instance is CompositeInstance {
            let possibleClassLabels : [String] = (instance as! CompositeInstance).getPossibleClassLabels()
            let size = possibleClassLabels.count
            let index = random.nextInt(maxRange: size)
            return possibleClassLabels[index]
        } else {
            let size = classLabels.count
            let index = random.nextInt(maxRange: size)
            return classLabels[index]
        }
    }
    
    /// Calculates the posterior probability distribution for the given instance according to random model.
    /// - Parameter instance: Instance for which posterior probability distribution is calculated.
    /// - Returns: Posterior probability distribution for the given instance.
    public override func predictProbability(instance: Instance) -> [String : Double] {
        var result : [String : Double] = [:]
        for classLabel in classLabels{
            result[classLabel] = 1.0 / Double(classLabels.count)
        }
        return result
    }
}
