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
    
    public init(pValue: Double, onlyTwoTailed: Bool){
        self.pValue = pValue
        self.onlyTwoTailed = onlyTwoTailed
    }
    
    public func oneTailed(alpha: Double) -> StatisticalTestResultType{
        if pValue < alpha{
            return StatisticalTestResultType.REJECT
        } else {
            return StatisticalTestResultType.FAILED_TO_REJECT
        }
    }
    
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
    
    public func getPValue() -> Double{
        return pValue
    }
}
