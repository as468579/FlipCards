//
//  GameViewController.swift
//  FlipGame
//
//  Created by User18 on 2019/6/23.
//  Copyright © 2019 jackliu. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionViewControl: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var flipNumberField: UILabel!
    @IBOutlet weak var maxFlipField: UILabel!
    
    var doc: DeckOfCards?
    var backgroundImage: UIImage?
    var numberOfCards: Int = 4
    var flipNumber: Int = 0
    var maxFlip: Int = 4
    var opening = [IndexPath]()
    var alreadyMatched = [IndexPath]()
    var level:Int = 1
    var scores = [Int]()
    
    
    // 取得手機螢幕大小
    let fullScreenSize = UIScreen.main.bounds.size
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background
        if let backgroundImage = backgroundImage{
            self.view.backgroundColor = UIColor(patternImage: backgroundImage)
        }
        doc = DeckOfCards(numberOfCards: numberOfCards)
        doc?.shuffle()
        
        // 初始化flip number
        flipNumber = 0
        flipNumberField.text = NSString(format:"%d", flipNumber) as String
        
        // 設定maxFlip
        maxFlipField.text = NSString(format: "%d", maxFlip) as String
        
        // 設定上下左右的間距
        collectionLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        // 設置cell的大小
        let w = fullScreenSize.width
        collectionLayout.itemSize = CGSize(width: w/4 - 20, height: 100)
        
        // 設置cell與cell之間的間距
        collectionLayout.minimumInteritemSpacing = 2
        collectionLayout.minimumLineSpacing = 4
        
        // 設定為上下捲動
        collectionLayout.scrollDirection = .vertical
        
        // 設定header尺寸
        //collectionLayout.headerReferenceSize = CGSize(width: w, height: 40)
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if  let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell,
            let card = doc?.getCard(index: indexPath.row)
            
        {
            // check the number of the opening cards
            if opening.count != 2 {
                
                // if covered
                if cell.tag == 0 {
                    
                    // insert card into opening list
                    opening.insert(indexPath, at: opening.count)
                    
                    // open the card
                    let face = card.getFace()
                    cell.imageView.image = UIImage(named: face)
                    
                    if opening.count == 2{
                        
                        // accumulate the flip number
                        flipNumber += 1
                        flipNumberField.text = NSString(format:"%d", flipNumber) as String
                        
                        checkPair(collectionView)
        
                    }
                    
                    cell.tag = 1
                }
            }
        }
    }
    
    func checkPair(_ collectionView: UICollectionView){

        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
            
            if  let cell1 = collectionView.cellForItem(at: self.opening[0]) as? CardCollectionViewCell,
                let cell2 = collectionView.cellForItem(at: self.opening[1]) as? CardCollectionViewCell
            {
                if cell1.imageView.image == cell2.imageView.image{
                    self.alreadyMatched.insert(self.opening[0], at: self.alreadyMatched.count)
                    self.alreadyMatched.insert(self.opening[1], at: self.alreadyMatched.count)
                    self.checkWin()
                }
                else{
                    cell1.imageView.image = UIImage(named: "卡背")
                    cell2.imageView.image = UIImage(named: "卡背")
                    cell1.tag = 0
                    cell2.tag = 0
                }
            }
            
            // clear the opening list
            self.opening.removeAll()
            
            // check Lose
            self.checkLose()
        }
    }
    
    func checkWin(){
        print(alreadyMatched.count)
        if alreadyMatched.count == numberOfCards{
            scores.insert(flipNumber, at: level - 1)
            let alertController = UIAlertController(title: "", message: "恭喜你過關了", preferredStyle: .alert)
            alertController.addAction(
                UIAlertAction(
                    title: "前往下一關",
                    style: .default,
                    handler:
                    { (action) in
                        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "Game") as? GameViewController{
                            if self.level == 1{
                                controller.numberOfCards = 6
                                controller.level = 2
                                controller.maxFlip = 8
                                controller.scores = self.scores
                                self.present(controller, animated: true, completion: nil)
                            }
                            else if self.level == 2{
                                controller.numberOfCards = 10
                                controller.level = 3
                                controller.maxFlip = 12
                                controller.scores = self.scores
                                self.present(controller, animated: true, completion: nil)
                            }
                            else if self.level == 3{
                                controller.numberOfCards = 16
                                controller.level = 4
                                controller.maxFlip = 16
                                controller.scores = self.scores
                                self.present(controller, animated: true, completion: nil)
                            }
                        }
                        
                        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "Settle") as? SettleViewController{
                            if self.level == 4{
                                controller.scores = self.scores
                                self.present(controller, animated: true, completion: nil)
                            }
                        }
                    }
                )
            )
            present(alertController, animated:true, completion: nil)
        }
    }
    
    func checkLose(){
        if flipNumber >= maxFlip{
            let alertController = UIAlertController(title: "", message: "請再接再厲", preferredStyle: .alert)
            alertController.addAction(
                UIAlertAction(
                    title: "重新挑戰",
                    style: .default,
                    handler:
                    { (action) in
                        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "Start") as? UINavigationController{
                            self.present(controller, animated: true, completion: nil)
                        }
                    }
                )
            )
            present(alertController, animated:true, completion: nil)
        }
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCards
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        cell.imageView.image = UIImage(named: "卡背")
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
