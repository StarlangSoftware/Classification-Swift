//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class ExperimentPerformance : Comparable{
    
    private var results : [Performance] = []
    private var containsDetails : Bool = true
    private var classification : Bool = true
    
    /**
     * A constructor which creates a new {@link ArrayList} of {@link Performance} as results.
     */
    public init(){
        
    }
    
    /**
     * A constructor that takes a file name as an input and takes the inputs from that file assigns these inputs to the errorRate
     * and adds them to the results {@link ArrayList} as a new {@link Performance}.
     - Parameters:
        - fileName: String input.
     */
    public init(fileName: String){
        containsDetails = false
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let url = thisDirectory.appendingPathComponent(fileName)
        do{
            let fileContent = try String(contentsOf: url, encoding: .utf8)
            let lines : [String] = fileContent.split(whereSeparator: \.isNewline).map(String.init)
            for line in lines{
                results.append(Performance(errorRate: Double(line)!))
            }
        }catch{
        }
    }
    
    public static func == (lhs: ExperimentPerformance, rhs: ExperimentPerformance) -> Bool {
        let accuracy1 = lhs.meanClassificationPerformance()!.getAccuracy();
        let accuracy2 = rhs.meanClassificationPerformance()!.getAccuracy()
        return accuracy1 == accuracy2
    }

    public static func < (lhs: ExperimentPerformance, rhs: ExperimentPerformance) -> Bool {
        let accuracy1 = lhs.meanClassificationPerformance()!.getAccuracy();
        let accuracy2 = rhs.meanClassificationPerformance()!.getAccuracy()
        return accuracy1 < accuracy2
    }

    /**
     * The add method takes a {@link Performance} as an input and adds it to the results {@link ArrayList}.
     - Parameters:
        - performance: {@link Performance} input.
     */
    public func add(performance: Performance){
        if !(performance is DetailedClassificationPerformance) {
            containsDetails = false
        }
        if !(performance is ClassificationPerformance) {
            classification = false
        }
        results.append(performance)
    }
    
    /**
     * The numberOfExperiments method returns the size of the results {@link ArrayList}.
     *
        - Returns: The results {@link ArrayList}.
     */
    public func numberOfExperiments() -> Int{
        return results.count
    }
    
    /**
     * The getErrorRate method takes an index as an input and returns the errorRate at given index of results {@link ArrayList}.
     - Parameters:
        - index: Index of results {@link ArrayList} to retrieve.
     - Returns: The errorRate at given index of results {@link ArrayList}.
     */
    public func getErrorRate(index: Int) -> Double{
        return results[index].getErrorRate()
    }
    
    /**
     * The getAccuracy method takes an index as an input. It returns the accuracy of a {@link Performance} at given index of results {@link ArrayList}.
     - Parameters:
        - index: Index of results {@link ArrayList} to retrieve.
     - Returns: The accuracy of a {@link Performance} at given index of results {@link ArrayList}.
     */
    public func getAccuracy(index: Int) -> Double?{
        if results[index] is ClassificationPerformance{
            return (results[index] as! ClassificationPerformance).getAccuracy()
        }
        return nil
    }
    
    /**
     * The meanPerformance method loops through the performances of results {@link ArrayList} and sums up the errorRates of each then
     * returns a new {@link Performance} with the mean of that summation.
     *
        - Returns: A new {@link Performance} with the mean of the summation of errorRates.
     */
    public func meanPerformance() -> Performance{
        var sumError : Double = 0.0
        for performance in results {
            sumError += performance.getErrorRate()
        }
        return Performance(errorRate: sumError / Double(results.count))
    }
    
    /**
     * The meanClassificationPerformance method loops through the performances of results {@link ArrayList} and sums up the accuracy of each
     * classification performance, then returns a new classificationPerformance with the mean of that summation.
     *
        - Returns: A new classificationPerformance with the mean of that summation.
     */
    public func meanClassificationPerformance() -> ClassificationPerformance?{
        if results.count == 0 || !classification {
            return nil
        }
        var sumAccuracy : Double = 0.0
        for performance in results {
            let classificationPerformance = performance as! ClassificationPerformance
            sumAccuracy += classificationPerformance.getAccuracy()
        }
        return ClassificationPerformance(accuracy: sumAccuracy / Double(results.count))
    }
    
    /**
     * The meanDetailedPerformance method gets the first confusion matrix of results {@link ArrayList}.
     * Then, it adds new confusion matrices as the {@link DetailedClassificationPerformance} of
     * other elements of results ArrayList' confusion matrices as a {@link DetailedClassificationPerformance}.
     *
        - Returns: A new {@link DetailedClassificationPerformance} with the {@link ConfusionMatrix} sum.
     */
    public func meanDetailedPerformance() -> DetailedClassificationPerformance?{
        if results.count == 0 || !containsDetails {
            return nil
        }
        let sum : ConfusionMatrix = (results[0] as! DetailedClassificationPerformance).getConfusionMatrix()
        for i in 1..<results.count {
            sum.addConfusionMatrix(confusionMatrix: (results[i] as! DetailedClassificationPerformance).getConfusionMatrix())
        }
        return DetailedClassificationPerformance(confusionMatrix: sum)
    }
    
    /**
     * The standardDeviationPerformance method loops through the {@link Performance}s of results {@link ArrayList} and returns
     * a new Performance with the standard deviation.
     *
        - Returns: A new Performance with the standard deviation.
     */
    public func standardDeviationPerformance() -> Performance{
        var sumErrorRate : Double = 0.0
        let averagePerformance = meanPerformance()
        for performance in results {
            sumErrorRate += pow(performance.getErrorRate() - averagePerformance.getErrorRate(), 2)
        }
        return Performance(errorRate: sqrt(sumErrorRate / Double((results.count - 1))))
    }
    
    /**
     * The standardDeviationClassificationPerformance method loops through the {@link Performance}s of results {@link ArrayList} and
     * returns a new {@link ClassificationPerformance} with standard deviation.
     *
        - Returns: A new {@link ClassificationPerformance} with standard deviation.
     */
    public func standardDeviationClassificationPerformance() -> ClassificationPerformance?{
        if results.count == 0 || !classification {
            return nil
        }
        var sumAccuracy : Double = 0.0
        var sumErrorRate : Double = 0.0
        let averageClassificationPerformance = meanClassificationPerformance()
        for performance in results {
            let classificationPerformance = performance as! ClassificationPerformance
            sumAccuracy += pow(classificationPerformance.getAccuracy() - averageClassificationPerformance!.getAccuracy(), 2)
            sumErrorRate += pow(classificationPerformance.getErrorRate() - averageClassificationPerformance!.getErrorRate(), 2)
        }
        return ClassificationPerformance(accuracy: sqrt(sumAccuracy / Double((results.count - 1))), errorRate: sqrt(sumErrorRate / Double((results.count - 1))));
    }
    
    /**
     * The isBetter method  takes an {@link ExperimentPerformance} as an input and returns true if the result of compareTo method is positive
     * and false otherwise.
     - Parameters:
        - experimentPerformance: {@link ExperimentPerformance} input.
     - Returns: True if the result of compareTo method is positive and false otherwise.
     */
    public func isBetter(experimentPerformance: ExperimentPerformance) -> Bool{
        return self > experimentPerformance
    }
    
}
