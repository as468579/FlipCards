//
//  StartViewController.swift
//  FlipGame
//
//  Created by User18 on 2019/6/24.
//  Copyright © 2019 jackliu. All rights reserved.
//

import UIKit
import UserNotifications

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .alert])
    }
}

class StartViewController: UIViewController {

    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var container: UIView!
    
    var scores: [Int] = [0, 0, 0, 0]
    
    
    
    @IBAction func unwindSegueToStart(segue: UIStoryboardSegue){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createNotification(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "世界上最棒的老師"
        content.subtitle  = "彼得潘"
        content.body = "彼得潘，是美的耕耘者，美的播種者。用美的陽光普照，用美的雨露滋潤，我們的心田才綠草如茵，繁花似錦。"
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        let imageURL = Bundle.main.url(forResource: "apple", withExtension: "png")
        let attachment = try! UNNotificationAttachment(identifier: "", url: imageURL!, options: nil)
        content.attachments = [attachment]
        let request = UNNotificationRequest(identifier: "idnetification1", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SettleViewController{
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
