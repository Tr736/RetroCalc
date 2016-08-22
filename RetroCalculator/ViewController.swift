//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Thomas Richardson on 8/22/16.
//  Copyright © 2016 Thomas Richardson. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    // MARK: - @IBOUTLETS

    @IBOutlet weak var counterLbl: UILabel!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    // MARK: - @Properties
    var btnSound : AVAudioPlayer!

    // MARK:- Initialize Views

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        

        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }
        catch let err as NSError {
            
            print(err.debugDescription)
            
        }
        counterLbl.text = "0"
        
        
    }
    // MARK: - @IBActions


    
    @IBAction func playRetroSound(_ sender: AnyObject) {
        
        runningNumber  += "\(sender.tag!)"
        counterLbl.text = runningNumber
        playSound()
        
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
    processOperation(operation: Operation.Divide)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: Operation.Multiply)

    }
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: Operation.Subtract)

    }
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: Operation.Add)

    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
    processOperation(operation: currentOperation)
    }
    
    @IBAction func clearBtnPressed(_ sender: AnyObject) {
        runningNumber = ""
        counterLbl.text = "0"
        currentOperation = Operation.Empty
    }
    
    // MARK: - Fucntions

    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
        
    }
    
    func processOperation(operation:Operation)
    {
        
        playSound()
        if currentOperation != Operation.Empty
        {
            if runningNumber != "" {
                
                rightValStr = runningNumber
                runningNumber = ""
                
                
                switch operation {
                case .Multiply:
                    if let leftVal = Double(leftValStr)
                    {
                        result = "\(Double(leftVal) * Double(rightValStr)!)"
                    }
                    break
                case .Divide:
                    if let leftVal = Double(leftValStr)
                    {
                        result = "\(Double(leftVal) / Double(rightValStr)!)"
                    }
                    break
                case .Subtract:
                    if let leftVal = Double(leftValStr)
                    {
                        result = "\(Double(leftVal) - Double(rightValStr)!)"
                    }

                    break
                    
                case .Add:
                    if let leftVal = Double(leftValStr)
                    {
                        result = "\(Double(leftVal) + Double(rightValStr)!)"
                    }
                    break
                default:
                   
                    break
                }
                
                leftValStr = result
                counterLbl.text = result
            }
            currentOperation = operation
        } else {
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
            
        }
    }

}

 
