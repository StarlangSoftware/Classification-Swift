//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 16.04.2021.
//

import Foundation

public class DecisionTree : ValidatedModel{
    
    private var root : DecisionNode
    
    /**
     * Constructor that sets root node of the decision tree.
     - Parameters:
        - root: DecisionNode type input.
     */
    public init(root: DecisionNode){
        self.root = root
    }
    
    /**
     * The predict method  performs prediction on the root node of given instance, and if it is null, it returns the possible class labels.
     * Otherwise it returns the returned class labels.
     - Parameters:
        - instance: Instance make prediction.
     - Returns: Possible class labels.
     */
    public override func predict(instance: Instance) -> String {
        var predictedClass = root.predict(instance: instance)
        if predictedClass == nil && instance is CompositeInstance {
            predictedClass = (instance as! CompositeInstance).getPossibleClassLabels()[0]
        }
        return predictedClass!
    }
    
    /**
     * The prune method takes a {@link DecisionNode} and an {@link InstanceList} as inputs. It checks the classification performance
     * of given InstanceList before pruning, i.e making a node leaf, and after pruning. If the after performance is better than the
     * before performance it prune the given InstanceList from the tree.
     - Parameters:
        - node:     DecisionNode that will be pruned if conditions hold.
        - pruneSet: Small subset of tree that will be removed from tree.
     */
    public func pruneNode(node: DecisionNode, pruneSet: InstanceList){
        if node.leaf{
            return
        }
        let before = testClassifier(data: pruneSet)
        node.leaf = true
        let after = testClassifier(data: pruneSet)
        if after.getAccuracy() < before.getAccuracy() {
            node.leaf = false
            for child in node.children! {
                pruneNode(node: child, pruneSet: pruneSet)
            }
        }
    }
    
    /**
     * The prune method takes an {@link InstanceList} and  performs pruning to the root node.
     - Parameters:
        - pruneSet: {@link InstanceList} to perform pruning.
     */
    public func prune(pruneSet: InstanceList){
        pruneNode(node: root, pruneSet: pruneSet)
    }
}
