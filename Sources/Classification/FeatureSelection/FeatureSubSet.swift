//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 18.04.2021.
//

import Foundation

public class FeatureSubSet : Hashable{
        
    public var indexList : [Int]
    
    /**
     * A constructor that sets the indexList {@link ArrayList}.
     - Parameters:
        - indexList: An ArrayList consists of integer indices.
     */
    public init(indexList: [Int]){
        self.indexList = indexList
    }
    
    /**
     * A constructor that takes number of features as input and initializes indexList with these numbers.
     - Parameters:
        - numberOfFeatures: Indicates the indices of indexList.
     */
    public init(numberOfFeatures: Int){
        indexList = []
        for i in 0..<numberOfFeatures{
            indexList.append(i)
        }
    }
    
    /**
     * A constructor that creates a new ArrayList for indexList.
     */
    public init(){
        indexList = []
    }
    
    public static func == (lhs: FeatureSubSet, rhs: FeatureSubSet) -> Bool {
        if lhs.indexList.count != rhs.indexList.count{
            return false
        }
        for i in 0..<lhs.indexList.count{
            if lhs.indexList[i] != rhs.indexList[i]{
                return false
            }
        }
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        for index in indexList{
            hasher.combine(index)
        }
    }

    /**
     * The clone method creates a new ArrayList with the elements of indexList and returns it as a new FeatureSubSet.
     *
        - Returns: A new ArrayList with the elements of indexList and returns it as a new FeatureSubSet.
     */
    public func copy(with zone: NSZone? = nil) -> Any {
        var newIndexList : [Int] = []
        for index in indexList{
            newIndexList.append(index)
        }
        return FeatureSubSet(indexList: newIndexList)
    }
    
    /**
     * The size method returns the size of the indexList.
     *
        - Returns: The size of the indexList.
     */
    public func size() -> Int{
        return indexList.count
    }
    
    /**
     * The get method returns the item of indexList at given index.
     - Parameters:
        - index: Index of the indexList to be accessed.
     - Returns: The item of indexList at given index.
     */
    public func get(index: Int) -> Int{
        return indexList[index]
    }
    
    /**
     * The contains method returns True, if indexList contains given input number and False otherwise.
     - Parameters:
        - featureNo: Feature number that will be checked.
     - Returns: True, if indexList contains given input number.
     */
    public func contains(featureNo: Int) -> Bool{
        return indexList.contains(featureNo)
    }
    
    /**
     * The add method adds given Integer to the indexList.
     - Parameters:
        - featureNo: Integer that will be added to indexList.
     */
    public func add(featureNo: Int){
        indexList.append(featureNo)
    }
    
    /**
     * The remove method removes the item of indexList at the given index.
     - Parameters:
        - index: Index of the item that will be removed.
     */
    public func remove(index: Int){
        indexList.remove(at: index)
    }
}
