//
//  ViewController.swift
//  PimpMyTip
//
//  Created by Antonio Orozco on 10/17/19.
//  Copyright © 2019 Antonio Orozco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var billBeforeTip: UITextField!
    
    @IBOutlet weak var billAfterTip: UILabel!
    
    @IBOutlet weak var serviceSlider: UISlider!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var tipPercentageLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        handleTipChanges()
        
        billBeforeTip.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
   
        
        guard let minValue = UserDefaults.standard.object(forKey: "minVal") as? Float else {
            
            return
            
        }
        
        guard let maxValue = UserDefaults.standard.object(forKey: "maxVal") as? Float else {
            
            return
            
        }
        
        serviceSlider.minimumValue = minValue
        
        serviceSlider.maximumValue = maxValue
        
    }
    
    @IBAction func serviceSliderWasUpdated(_ sender: Any) {
        
        handleTipChanges()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        
        super.touchesBegan(touches, with: event)
        
        handleTipChanges()
    
    }
    
    
    
    func handleTipChanges(){
        
        guard var theBillString =  billBeforeTip!.text else {
            
            print("There's no bill amount")
            
            return
        }
        
        theBillString = theBillString.replacingOccurrences(of: "$", with: "")
        
        theBillString = theBillString.replacingOccurrences(of: ",", with: "")
        
        guard let theBillFloat = theBillString.float else {
            
            print("Invalid input")
            
            return
            
        }
        
        let tip : Float = serviceSlider.value * Float(theBillFloat)
        
        let tipString: String = String(format: "$%.2f", tip)
        
        
        
        let totalWithTip: String = String(format: "$%.2f",tip + Float(theBillFloat))
        
        tipPercentageLabel.text = String(format: "%.2f%%", serviceSlider.value * 100.0)
        
        billAfterTip.text = "\(totalWithTip.currency)"
        
        tipLabel.text = "\(tipString.currency)"
        
        
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("Return pressed")
        
        view.endEditing(true)
        
        handleTipChanges()
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
       
        print("Return pressed")
        
        handleTipChanges()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if newText.count >= 9 {
            
            return newText.count < 9
        
        } else {
        
            
            let text: NSString = (textField.text ?? "") as NSString
                   
            let finalString = text.replacingCharacters(in: range, with: string)
            
            // 'currency' is a String extension that doews all the number styling
            billBeforeTip.text = finalString.currency

            // returning 'false' so that textfield will not be updated here, instead from styling extension
            return false
            
        }
        
    }
    
}
