//
//  ViewController.swift
//  HandoffBsp
//
//  Created by Christian Bleske on 01.02.16.
//  Copyright © 2016 Christian Bleske. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet var uiTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiTextView.delegate = self;
        createUserActivity();
    }
    
    func createUserActivity() {
        let nsUserActivity = NSUserActivity(activityType: "de.christian.bleske.note")
        nsUserActivity.title = "Notiz"
        nsUserActivity.userInfo = ["content": ""]
        userActivity = nsUserActivity
        userActivity?.becomeCurrent()

    }
    
    override func updateUserActivityState(_ activity: NSUserActivity) {
        activity.addUserInfoEntries(from: ["content": self.uiTextView.text])
        print("Update UserActivityState...")
        print(activity.userInfo?["content"] as! String)
        super.updateUserActivityState(activity)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.updateUserActivityState(userActivity!)
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.updateUserActivityState(userActivity!)
        return true
    }
    
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        print("Restore UserActivity...")
        print(activity.userInfo?["content"] as! String)
        
        self.uiTextView.text = activity.userInfo?["content"] as! String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

