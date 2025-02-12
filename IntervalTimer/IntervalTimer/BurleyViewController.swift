//
//  BurleyViewController.swift
//  IntervalTimer
//
//  Created by Michael Montella on 4/12/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit
import AudioToolbox

class BurleyViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var burleyLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var setNumberTextField: UITextField!
    
    
    var timer = NSTimer()
    var restTimer = NSTimer()
    var second = 600
    var climbs = 0
    var currentClimb = 0
    var isCounting = true
    var infoOpen = false
    
    @IBAction func backButton(sender: AnyObject) {
        timer.invalidate()
        restTimer.invalidate()
    }
    
    @IBAction func startButton(sender: AnyObject) {
        if isCounting {
            if (Int(setNumberTextField.text!) != nil) {
                climbs = Int(setNumberTextField.text!)!
                startTimer()
            } else {
                climbs = 2
                startTimer()
            }
            isCounting = false
            button.setTitle("Stop", forState: .Normal)
        } else {
            timer.invalidate()
            timerLabel.text = "10:00"
            second = 600
            animation()
            button.setTitle("Start", forState: .Normal)
        }
    }
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(BurleyViewController.countDown), userInfo: nil, repeats: true)
        second = 600
    }
    
    func countDown() {
        if currentClimb < climbs {
            if second > 10 {
                timerLabel.textColor = UIColor.blackColor()
                second -= 1
                print(second)
                timerLabel.text = secondsToTime(second)
                if second == 30 || second == 10 {
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                }
            } else if second > 0 {
                timerLabel.textColor = UIColor.redColor()
                second -= 1
                print(second)
                if second < 5 {
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                }
                timerLabel.text = String(second)
            } else {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                currentClimb += 1
                second = 600
                countDown()
                print("Over")
            }
        } else {
            timer.invalidate()
            animation()
        }
    }
    
    func secondsToTime(seconds: Int) -> String {
        var minutes = 0
        var seconds2 = 0
        if seconds % 60 == 0 {
            minutes = seconds / 60
        } else {
            minutes = seconds / 60
            seconds2 = seconds - (minutes * 60)
        }
        
        return ("\(minutes):\(seconds2)")
    }
    
    func animation() {
        UIView.animateWithDuration(0.5) { 
            self.timerLabel.alpha = 0
            self.button.alpha = 0
            self.topLabel.alpha = 1
            self.setNumberTextField.alpha = 1
            self.burleyLabel.alpha = 0
            self.infoLabel.alpha = 0
        }
    }
    
    func animation2() {
        UIView.animateWithDuration(0.5) { 
            self.timerLabel.alpha = 0
            self.button.alpha = 0
            self.topLabel.alpha = 0
            self.setNumberTextField.alpha = 0
            self.burleyLabel.alpha = 1
            self.infoLabel.alpha = 1
        }
    }
    
    func info() {
        if self.timerLabel.alpha == 0 {
            if infoOpen {
                animation()
                infoOpen = false
            } else {
                animation2()
                infoOpen = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button.layer.cornerRadius = 3
        
        setNumberTextField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MinuteBoulderViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let infoButton = UIButton(type: .InfoLight)
        infoButton.addTarget(self, action: #selector(MinuteBoulderViewController.info), forControlEvents: .TouchUpInside)
        let infoBarButton = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = infoBarButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.timerLabel.alpha = 0
        self.button.alpha = 0
        self.burleyLabel.alpha = 0
        self.infoLabel.alpha = 0
    }
    
    func dismissKeyboard() {    // Dismiss keyboard on tap
        view.endEditing(true)
        UIView.animateWithDuration(0.5) { () -> Void in
            self.button.alpha = 1
            self.timerLabel.alpha = 1
            self.topLabel.alpha = 0
            self.setNumberTextField.alpha = 0
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {    // Dismiss keyboard on tap of return
        setNumberTextField.resignFirstResponder()
        UIView.animateWithDuration(0.5) { () -> Void in
            self.button.alpha = 1
            self.timerLabel.alpha = 1
            self.topLabel.alpha = 0
            self.setNumberTextField.alpha = 0
        }
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
