//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.04.2021.
//

import Foundation

public class StatisticalTestResult {
    
    private var pValue : Double
    private var onlyTwoTailed : Bool
    
    /// Constructor of the StatisticalTestResult. It sets the attribute values.
    /// - Parameters:
    ///   - pValue: p value of the statistical test result
    ///   - onlyTwoTailed: True, if this test applicable only two tailed tests, false otherwise.
    public init(pValue: Double, onlyTwoTailed: Bool){
        self.pValue = pValue
        self.onlyTwoTailed = onlyTwoTailed
    }
    
    /// Returns reject or failed to reject, depending on the alpha level and p value of the statistical test that checks
    /// one tailed null hypothesis such as mu1 is less than mu2. If p value is less than the alpha level, the test rejects the null
    /// hypothesis. Otherwise, it fails to reject the null hypothesis.
    /// - Parameter alpha: Alpha level of the test
    /// - Returns: If p value is less than the alpha level, the test rejects the null hypothesis. Otherwise, it fails to
    /// reject the null hypothesis.
    public func oneTailed(alpha: Double) -> StatisticalTestResultType{
        if pValue < alpha{
            return StatisticalTestResultType.REJECT
        } else {
            return StatisticalTestResultType.FAILED_TO_REJECT
        }
    }
    
    /// Returns reject or failed to reject, depending on the alpha level and p value of the statistical test that checks
    /// one tailed null hypothesis such as mu1 is less than mu2 or two tailed null hypothesis such as mu1 = mu2. If the null
    /// hypothesis is two tailed, and p value is less than the alpha level, the test rejects the null hypothesis.
    /// Otherwise, it fails to reject the null hypothesis. If the null  hypothesis is one tailed, and p value is less
    /// than alpha / 2 or p value is larger than 1 - alpha / 2, the test  rejects the null  hypothesis. Otherwise, it
    /// fails to reject the null hypothesis.
    /// - Parameter alpha: Alpha level of the test
    /// - Returns: If the null  hypothesis is two tailed, and p value is less than the alpha level, the test rejects the
    /// null hypothesis.  Otherwise, it fails to reject the null hypothesis. If the null  hypothesis is one tailed, and
    /// p value is less  than alpha / 2 or p value is larger than 1 - alpha / 2, the test  rejects the null  hypothesis.
    /// Otherwise, it  fails to reject the null hypothesis.
    public func twoTailed(alpha: Double) -> StatisticalTestResultType{
        if onlyTwoTailed{
            if pValue < alpha{
                return StatisticalTestResultType.REJECT
            } else {
                return StatisticalTestResultType.FAILED_TO_REJECT
            }
        } else {
            if pValue < alpha / 2 || pValue > 1 - alpha / 2{
                return StatisticalTestResultType.REJECT
            } else {
                return StatisticalTestResultType.FAILED_TO_REJECT
            }
        }
    }
    
    /// Accessor for the p value of the statistical test result.
    /// - Returns: p value of the statistical test result
    public func getPValue() -> Double{
        return pValue
    }
}
