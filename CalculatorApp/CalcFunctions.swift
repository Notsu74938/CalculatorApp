//
//  CalcFunctions.swift
//  CalculatorApp
//
//  Created by 野津天志 on 2020/07/28.
//  Copyright © 2020 野津天志. All rights reserved.
//

import UIKit


extension ViewController {
    
    
    /// 入力値に基づいた処理をする
    /// - Parameter number: 入力値（String）
    func inputNumber(_ number: String) {
        switch number {
            
        case "0"..."9":
            reflectNumber(number)                       //ラベルに入力値を反映させる
            
        case "+","-","x","÷":
            calcByStatus()                              // ステータスによる計算をする
            changeStatus(number: number)                // ステータスを変える
            displayResult()                             // ラベルに反映する
            holdNumber = "0"                            // holdNumberの初期化
            
        case ".":
            confirmDecimalPoint(number: number)
            
        case "=":
            calcByStatus()                              // ステータスによる計算をする
            displayResult()                             // ラベルに反映する
            holdNumber = "0"                            // holdNumberの初期化
            calculateStatus = .none                     // ステータスの初期化
            
        case "C":
            clear()
            
        default:
            break
        }
    }
    
    
    
    
    /// 1. 入力値（number）をholdnumberに代入またはプラスする
    /// 2. holdnumberをラベルに反映
    /// - Parameter number:　入力値（String）
    func reflectNumber(_ number: String) {
        
        if resultLabel.text == "0" || holdNumber == "0" {
            holdNumber = number
        }else{
            holdNumber += number
        }
        resultLabel!.text = holdNumber
    }
    
    
    
    /// ステータスによる計算をする
    func calcByStatus() {
        
        if holdNumber != "0" {
            switch calculateStatus {
            case .none:
                resultNumber = Double(holdNumber)!
            case .plus:
                resultNumber += Double(holdNumber)!
            case .minus:
                resultNumber -= Double(holdNumber)!
            case .multiplication:
                resultNumber *= Double(holdNumber)!
            case .division:
                resultNumber /= Double(holdNumber)!
            }
        }
    }
    
    
    
    /// ステータスを変える
    /// - Parameter number: 入力値（String）
    func changeStatus(number: String) {
        switch number{
            
        case "+":
            calculateStatus = .plus
        case "-":
            calculateStatus = .minus
        case "x":
            calculateStatus = .multiplication
        case "÷":
            calculateStatus = .division
        default:
            break
        }
    }
    
    
    
    //
    /// 小数点が含まれているか確認し、ラベルに反映させる
    /// - Parameter number: 入力値（String）
    func confirmDecimalPoint(number: String) {
        if(holdNumber.range(of: ".") == nil) {
            if holdNumber == "0"{
                holdNumber = "0."
            }else{
                holdNumber += number
            }
            resultLabel.text = holdNumber
        }
    }
    
    
    
    /// 計算結果をラベルに表示
    func displayResult(){
        if String(resultNumber).hasSuffix(".0"){
            resultLabel.text = String(Int(resultNumber))
        }else{
            resultLabel.text = String(resultNumber)
        }
    }
    
    
    
    /// 初期化
    func clear() {
        resultLabel.text = "0"
        holdNumber = "0"
        resultNumber = 0
        calculateStatus = .none
    }
    
    
}

