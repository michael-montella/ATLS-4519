//
//  MinuteBoulderViewController.swift
//  IntervalTimer
//
//  Created by Michael Montella on 3/7/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit
import AudioToolbox

class MinuteBoulderViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var setNumberTextField: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var minuteBoulderLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var timer = NSTimer()
    var restTimer = NSTimer()
    var second = 60
    var climbs = 0
    var currentClimb = 0
    var isCounting = true
    var infoOpen = false
    
    @IBOutlet weak var button: UIButton!
    /*
        TODO:
            Right now, the minute boulder problems don't have 4 minute rests in between but everything else works.  For next edit,
            when user sets how many climbs they want, set it to have 4 minutes of climbing, 4 minutes of rest, for the amount of 
            climbs they want.
    */
    
    
    @IBAction func backButton(sender: AnyObject) {
        timer.invalidate()
        restTimer.invalidate()
    }
    
    @IBAction func startTimer(sender: AnyObject) {
        if isCounting {
            if (Int(setNumberTextField.text!) != nil) {
                climbs = Int(setNumberTextField.text!)!
                startTimer()
            } else {
                climbs = 6
                startTimer()
            }
            isCounting = false
            startButton.setTitle("Stop", forState: .Normal)
        } else {
            timer.invalidate()
            timerLabel.text = "60"
            second = 0
            animation()
            startButton.setTitle("Start", forState: .Normal)
        }
    }
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(MinuteBoulderViewController.countDown), userInfo: nil, repeats: true)
        second = 60
    }
    
    func countDown() {
        if currentClimb < climbs {
            print(currentClimb)
            if second > 10 {
                timerLabel.textColor = UIColor.blackColor()
                second -= 1
                print(second)
                timerLabel.text = String(second)
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
                second = 60
                countDown()
                print("Over")
            }
        } else {
            timer.invalidate()
            animation()
        }
    }
    
    func animation() {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.timerLabel.alpha = 0
            self.startButton.alpha = 0
            self.topLabel.alpha = 1
            self.setNumberTextField.alpha = 1
            self.minuteBoulderLabel.alpha = 0
            self.infoLabel.alpha = 0
        }
    }
    
    func animation2() {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.timerLabel.alpha = 0
            self.startButton.alpha = 0
            self.topLabel.alpha = 0
            self.setNumberTextField.alpha = 0
            self.minuteBoulderLabel.alpha = 1
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
        
        // Do any additional setup after loading the view.
        
        button.layer.cornerRadius = 3
        
        setNumberTextField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MinuteBoulderViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let infoButton = UIButton(type: .InfoLight)
        infoButton.addTarget(self, action: #selector(MinuteBoulderViewController.info), forControlEvents: .TouchUpInside)
        let infoBarButton = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = infoBarButton
    }
    
    override func viewWillAppear(animated: Bool) {
        self.timerLabel.alpha = 0
        self.startButton.alpha = 0
        self.minuteBoulderLabel.alpha = 0
        self.infoLabel.alpha = 0
    }
    
    func dismissKeyboard() {    // Dismiss keyboard on tap
        view.endEditing(true)
        UIView.animateWithDuration(0.5) { () -> Void in
            self.startButton.alpha = 1
            self.timerLabel.alpha = 1
            self.topLabel.alpha = 0
            self.setNumberTextField.alpha = 0
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {    // Dismiss keyboard on tap of return
        setNumberTextField.resignFirstResponder()
        UIView.animateWithDuration(0.5) { () -> Void in
            self.startButton.alpha = 1
            self.timerLabel.alpha = 1
            self.topLabel.alpha = 0
            self.setNumberTextField.alpha = 0
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
