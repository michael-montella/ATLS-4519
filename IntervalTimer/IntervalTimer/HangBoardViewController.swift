//
//  HangBoardViewController.swift
//  IntervalTimer
//
//  Created by Michael Montella on 3/2/16.
//  Copyright © 2016 Michael Montella. All rights reserved.
//

import UIKit
import AudioToolbox

class HangBoardViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var setNumberTextField: UITextField!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var hangBoardLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    
    var timer = NSTimer()
    var restTimer = NSTimer()
    var second = 0
    var reps = 0
    var currentRep = 0
    var isCounting = true
    var infoOpen = false
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func startTimer(sender: AnyObject) {
        if isCounting {
            if (Int(setNumberTextField.text!) != nil) {     // Checks if text field is not nil
                reps = Int(setNumberTextField.text!)!       // Set amount of reps
                startTimer()                                // Start timer
            } else {
                reps = 5
                startTimer()
            }
            isCounting = false
            startButton.setTitle("Stop", forState: .Normal)
        } else {
            timer.invalidate()
            timerLabel.text = "0"
            second = 0
            animation()
            startButton.setTitle("Start", forState: .Normal)
        }
        
    }
    @IBAction func backButton(sender: AnyObject) {
        timer.invalidate()
        restTimer.invalidate()
    }
    
    func startTimer() {     // Starts hang timer
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(HangBoardViewController.countDown), userInfo: nil, repeats: true)
    }
    
    // TODO
    /*
    
    Make it look pretty
    Integrate vibration
    Make main screen look pretty
    Integrate option for user to set the time intervals 
        Use more text fields and variable instead to test if second is less than variable
    
*/

    func countDown() {
        timerLabel.textColor = UIColor.blackColor()     // Changes color to black
        if currentRep < reps {                          // Checks to make sure you haven't exceeded target reps
            if second < 10 {
                second += 1
                print(second)
                timerLabel.text = String(second)
            } else {    // If > 10 seconds, invalidate timer and start rest timer
                timer.invalidate()
                second = 0
                restTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(HangBoardViewController.restTime), userInfo: nil, repeats: true)
                restLabel.alpha = 1
                currentRep += 1
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        } else {
            print("Over")
            timerLabel.text = "0"
            timer.invalidate()
            animation()
        }
    }
    
    func restTime() {   // Starts rest timer
        if second < 5 {
            second += 1
            print(second)
            timerLabel.textColor = UIColor.redColor()   // Changes color to red to indicate rest
            timerLabel.text = String(second)
        } else {
            restTimer.invalidate()
            startTimer()
            second = 0
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            restLabel.alpha = 0
        }
    }
    
    func animation() {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.timerLabel.alpha = 0
            self.startButton.alpha = 0
            self.topLabel.alpha = 1
            self.setNumberTextField.alpha = 1
            self.hangBoardLabel.alpha = 0
            self.infoLabel.alpha = 0
        }
    }
    
    func animation2() {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.timerLabel.alpha = 0
            self.startButton.alpha = 0
            self.topLabel.alpha = 0
            self.setNumberTextField.alpha = 0
            self.infoLabel.alpha = 1
            self.hangBoardLabel.alpha = 1
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HangBoardViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let infoButton = UIButton(type: .InfoLight)
        infoButton.addTarget(self, action: #selector(HangBoardViewController.info), forControlEvents: .TouchUpInside)
        let infoBarButton = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = infoBarButton
    }
    
    override func viewWillAppear(animated: Bool) {
        self.timerLabel.alpha = 0
        self.startButton.alpha = 0
        self.hangBoardLabel.alpha = 0
        self.infoLabel.alpha = 0
        restLabel.alpha = 0
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
