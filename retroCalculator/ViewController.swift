//
//  ViewController.swift
//  retroCalculator
//
//  Created by mohammed rampurawala on 9/6/18.
//  Copyright © 2018 mohammed rampurawala. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound : AVAudioPlayer!
    
    enum Operation {
        case Divide
        case Add
        case Subtract
        case Multiply
        case Empty
    }
    
    var runningNumber = ""
    var currentOperation = Operation.Empty
    
    var leftHandValue = ""
    var rightHandValue = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel.text="0"
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let audioUrl = URL(fileURLWithPath: path!)
        do{
            try btnSound = AVAudioPlayer(contentsOf: audioUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        runningNumber.append("\(sender.tag)")
        outputLabel.text = runningNumber
    }
    
    @IBAction func processDivide(_ sender: Any) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func processMultiplication(_ sender: Any) {
        processOperation(operation: .Multiply)
    }
    
    
    @IBAction func processSubstraction(_ sender: Any) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func processAddition(_ sender: Any) {
        processOperation(operation: .Add)
    }
    
    @IBAction func processEquals(_ sender: Any) {
        processOperation(operation: currentOperation)
    }
    
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation:Operation){
        playSound()
        if currentOperation != Operation.Empty{
            //If operation is not empty then perform the operation and running number is not empty.
            if runningNumber != ""{
                rightHandValue = runningNumber;
                runningNumber = ""
                switch(currentOperation){
                case .Divide:
                    outputLabel.text = "\(Double(leftHandValue)! / Double(rightHandValue)!)"
                    break
                case .Add:
                    outputLabel.text = "\(Double(leftHandValue)! + Double(rightHandValue)!)"
                    break
                case .Subtract:
                    outputLabel.text = "\(Double(leftHandValue)! - Double(rightHandValue)!)"
                    break
                case .Multiply:
                    outputLabel.text = "\(Double(leftHandValue)! * Double(rightHandValue)!)"
                case .Empty:
                    print("No Operation")
                    break
                }
                
                result = outputLabel.text!
                leftHandValue = result
                
            }
            currentOperation = operation
        }else{
            //if empty then assign the left hand value.
            currentOperation = operation
            leftHandValue = runningNumber
            runningNumber=""
        }
    }
    
    func performCalculation(operation : Operation){
        
        
    }
    
    
}

