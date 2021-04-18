//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation
import Math

public class Pca : TrainedFeatureFilter{
    
    private var covarianceExplained : Double = 0.99
    private var eigenvectors : [Eigenvector] = []
    private var numberOfDimensions : Int = -1
    
    /**
     * Constructor that sets the dataSet and covariance explained. Then calls train method.
     - Parameters:
        - dataSet:             DataSet that will bu used.
        - covarianceExplained: Number that shows the explained covariance.
     */
    public init(dataSet: DataSet, covarianceExplained: Double){
        self.covarianceExplained = covarianceExplained
        super.init(dataSet: dataSet)
        train()
    }
    
    /**
     * Constructor that sets the dataSet and dimension. Then calls train method.
     - Parameters:
        - dataSet:            DataSet that will bu used.
        - numberOfDimensions: Dimension number.
     */
    public init(dataSet: DataSet, numberOfDimensions: Int){
        self.numberOfDimensions = numberOfDimensions
        super.init(dataSet: dataSet)
        train()
    }
    
    /**
     * Constructor that sets the dataSet and dimension. Then calls train method.
     - Parameters:
        - dataSet: DataSet that will bu used.
     */
    public override init(dataSet: DataSet){
        super.init(dataSet: dataSet)
        train()
    }
    
    /**
     * The removeUnnecessaryEigenvectors methods takes an ArrayList of Eigenvectors. It first calculates the summation
     * of eigenValues. Then it finds the eigenvectors which have lesser summation than covarianceExplained and removes these
     * eigenvectors.
     */
    private func removeUnnecessaryEigenvectors(){
        var sum : Double = 0.0
        var currentSum : Double = 0.0
        for eigenvector in eigenvectors {
            sum += eigenvector.getEigenvalue()
        }
        var toBeRemoved : [Eigenvector] = []
        for eigenvector in eigenvectors {
            if currentSum / sum < covarianceExplained {
                currentSum += eigenvector.getEigenvalue()
            } else {
                toBeRemoved.append(eigenvector)
            }
        }
        eigenvectors.removeAll(where: {toBeRemoved.contains($0)} )
    }
    
    /**
     * The removeAllEigenvectorsExceptTheMostImportantK method takes an {@link ArrayList} of {@link Eigenvector}s and removes the
     * surplus eigenvectors when the number of eigenvectors is greater than the dimension.
     */
    private func removeAllEigenvectorsExceptTheMostImportantK(){
        var toBeRemoved : [Eigenvector] = []
        var i : Int = 0
        for eigenvector in eigenvectors {
            if i >= numberOfDimensions {
                toBeRemoved.append(eigenvector)
            }
            i += 1
        }
        eigenvectors.removeAll(where: {toBeRemoved.contains($0)} )
    }
    
    /**
     * The train method creates an averageVector from continuousAttributeAverage and a covariance {@link Matrix} from that averageVector.
     * Then finds the eigenvectors of that covariance matrix and removes its unnecessary eigenvectors.
     */
    public override func train() {
        let averageVector = Vector(values: dataSet.getInstanceList().continuousAttributeAverage())
        let covariance = dataSet.getInstanceList().covariance(average: averageVector)
        eigenvectors = covariance.characteristics()
        if numberOfDimensions != -1 {
            removeAllEigenvectorsExceptTheMostImportantK()
        } else {
            removeUnnecessaryEigenvectors()
        }
    }
    
    /**
     * The convertInstance method takes an {@link Instance} as an input and creates a {@link java.util.Vector} attributes from continuousAttributes.
     * After removing all attributes of given instance, it then adds new {@link ContinuousAttribute} by using the dot
     * product of attributes Vector and the eigenvectors.
     - Parameters:
        - instance: Instance that will be converted to {@link ContinuousAttribute} by using eigenvectors.
     */
    public override func convertInstance(instance: Instance) {
        let attributes = Vector(values: instance.continuousAttributes())
        instance.removeAllAttributes()
        for eigenvector in eigenvectors {
            instance.addAttribute(attribute: ContinuousAttribute(value: attributes.dotProduct(v: eigenvector)))
        }
    }
    
    /**
     * The convertDataDefinition method gets the data definitions of the dataSet and removes all the attributes. Then adds
     * new attributes as CONTINUOUS.
     */
    public override func convertDataDefinition() {
        let dataDefinition = dataSet.getDataDefinition()
        dataDefinition.removeAllAttributes()
        for _ in 0..<eigenvectors.count {
            dataDefinition.addAttribute(attributeType: AttributeType.CONTINUOUS)
        }
    }
}
