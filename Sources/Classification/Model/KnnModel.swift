//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation

public class KnnModel : Model{
    
    private var data: InstanceList
    private var k: Int
    private var distanceMetric: DistanceMetric
    
    /**
     * Constructor that sets the data {@link InstanceList}, k value and the {@link DistanceMetric}.
     - Parameters:
        - data:           {@link InstanceList} input.
        - k :             K value.
        - distanceMetric: {@link DistanceMetric} input.
     */
    public init(data: InstanceList, k: Int, distanceMetric: DistanceMetric){
        self.data = data
        self.k = k
        self.distanceMetric = distanceMetric
    }
    
    /**
     * The nearestNeighbors method takes an {@link Instance} as an input. First it gets the possible class labels, then loops
     * through the data {@link InstanceList} and creates new {@link ArrayList} of {@link KnnInstance}s and adds the corresponding data with
     * the distance between data and given instance. After sorting this newly created ArrayList, it loops k times and
     * returns the first k instances as an {@link InstanceList}.
     - Parameters:
        - instance: {@link Instance} to find nearest neighbors/
     - Returns: The first k instances which are nearest to the given instance as an {@link InstanceList}.
     */
    public func nearestNeighbors(instance: Instance) -> InstanceList{
        let result : InstanceList = InstanceList()
        var instances : [KnnInstance] = []
        var possibleClassLabels : [String]? = nil
        if instance is CompositeInstance {
            possibleClassLabels = (instance as! CompositeInstance).getPossibleClassLabels()
        }
        for i in 0..<data.size() {
            if !(instance is CompositeInstance) || possibleClassLabels!.contains(data.get(index: i).getClassLabel()) {
                instances.append(KnnInstance(instance: data.get(index: i), distance: distanceMetric.distance(instance1: data.get(index: i), instance2: instance)))
            }
        }
        instances.sort()
        for i in 0..<min(k, instances.count) {
            result.add(instance: instances[i].getInstance())
        }
        return result
    }
    
    /**
     * The predict method takes an {@link Instance} as an input and finds the nearest neighbors of given instance. Then
     * it returns the first possible class label as the predicted class.
     - Parameters:
        - instance: {@link Instance} to make prediction.
     - Returns: The first possible class label as the predicted class.
     */
    public override func predict(instance: Instance) -> String {
        let neighbors = nearestNeighbors(instance: instance)
        var predictedClass : String
        if instance is CompositeInstance && neighbors.size() == 0 {
            predictedClass = (instance as! CompositeInstance).getPossibleClassLabels()[0]
        } else {
            predictedClass = Model.getMaximum(classLabels: neighbors.getClassLabels())
        }
        return predictedClass
    }
    
    public override func predictProbability(instance: Instance) -> [String : Double] {
        let neighbors = nearestNeighbors(instance: instance)
        return neighbors.classDistribution().getProbabilityDistribution()
    }
}
