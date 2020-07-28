//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 野津天志 on 2020/07/16.
//  Copyright © 2020 野津天志. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    
    @IBOutlet weak var collectionView: UICollectionView! // collectionView
    @IBOutlet weak var resultLabel: UILabel! //resultLabel
    @IBOutlet weak var calculatorHeightConstraint: NSLayoutConstraint! // calculatorHeightConstraint
    
    var holdNumber = "0"
    var resultNumber: Double = 0
    
    enum CalculateStatus{
        case none, plus, minus, multiplication, division
    }
    var calculateStatus: CalculateStatus = .none
    
    let cellId = "Cell" // セルのidentifier
    let numbers = [     // 表示するセルの値
        ["C","%","$","÷"],
        ["7","8","9","x"],
        ["4","5","6","-"],
        ["1","2","3","+"],
        ["0",".","="],
    ]
    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUp()
        
        
    }
    
    
    
    /// 初期設定
    func setUp() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 左右に余白を指定
        collectionView.contentInset = .init(top: 0, left: 14, bottom: 0, right: 14)
        //collectionViewの高さを指定
        calculatorHeightConstraint.constant = view.frame.width * 1.4
        
        
        
    }
    
    
    
}





















extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    
    // セクションの数を返す
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numbers.count
    }
    
    
    
    // 各セクション内のセルの数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers[section].count
    }
    
    
    
    // セクションのヘッダーのサイズ指定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 14)
        
    }
    
    
    
    // セルの生成
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)   // セルのidentifierと紐付ける
        let cellLabel = cell.contentView.viewWithTag(1) as! UILabel
        cellLabel.text = numbers[indexPath.section][indexPath.row] // セルのラベルnumbersの値を反映する
        
        cell.layer.cornerRadius = cell.frame.width / 2  // セルを円形にする
        
        // 変数numberStringにnumbersの要素数分、要素を代入する,色の指定
        numbers[indexPath.section][indexPath.row].forEach{ (numberString) in
            if "0"..."9" ~= numberString || "." == numberString{
                cell.backgroundColor = .darkGray
                if "0" == numberString{
                    cell.layer.cornerRadius = cell.frame.width / 4.5
                }
            }else if "C" == numberString || "%" == numberString || "$" == numberString{
                cell.backgroundColor = .gray
            }else{
                cell.backgroundColor = .orange
            }
        }
        
        return cell
    }
    
    
    
    // セルのサイズ指定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // セルの横幅
        var width = (collectionView.frame.width - 14 * 5) / 4
        let height = width
        
        if indexPath.section == 4 && indexPath.row == 0{
            width = width * 2 + 14 + 6
        }
        
        return CGSize(width: width, height: height)
        
    }
    
    
    
    // セルが選択された時
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let number = numbers[indexPath.section][indexPath.row]
        inputNumber(number)
    }
}






































