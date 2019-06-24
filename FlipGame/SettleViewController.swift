//
//  SettleViewController.swift
//  FlipGame
//
//  Created by User18 on 2019/6/24.
//  Copyright © 2019 jackliu. All rights reserved.
//

import UIKit

class SettleViewController: UIViewController {

 
    @IBOutlet var levelScore: [UILabel]!
    
    var scores =  [Int]()
    let max: [Int] = [4 , 8, 12 ,16]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...3{
            levelScore[i].text = NSString(format: "%d / %d", scores[i], max[i]) as String
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? StartViewController{
            controller.scores = scores
        }
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
