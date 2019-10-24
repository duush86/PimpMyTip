//
//  SettingsViewController.swift
//  PimpMyTip
//
//  Created by Antonio Orozco on 10/22/19.
//  Copyright © 2019 Antonio Orozco. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var minPercentageLabel: UILabel!
    
    @IBOutlet weak var minPercentageSlider: UISlider!
    
    @IBOutlet weak var maxPercentageLabel: UILabel!
    
    @IBOutlet weak var maxPercentageSlider: UISlider!
    
    @IBOutlet weak var saveTipValuesButton: UIButton!
    
    @IBOutlet weak var restoreDefaults: UIButton!
    
    
    override func viewDidLoad() {
 
        super.viewDidLoad()
        
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setupView()
        
    }
    
    func setupView() {
        
        guard let minValue = UserDefaults.standard.object(forKey: "minVal") as? Float else {
            
            setupControllsToDefault()
            
            disableResetButton()

            return
               
           }
           
           guard let maxValue = UserDefaults.standard.object(forKey: "maxVal") as? Float else {
            
            setupControllsToDefault()
            
            disableResetButton()
               
            return
               
           }
           
        
        setupControllsToNotDefault(withMinVal: minValue, withMaxVal: maxValue)

        
    }
    
    func setupControllsToNotDefault(withMinVal minVal: Float, withMaxVal maxVal: Float){
        
        minPercentageSlider.value = minVal
               
        minPercentageLabel.text = String(format: "%.2f%%", minPercentageSlider.value * 100.0)

               
        maxPercentageSlider.value = maxVal
               
        maxPercentageLabel.text = String(format: "%.2f%%", maxPercentageSlider.value * 100.0)
        
    }
    
    func setupControllsToDefault(){
        
        minPercentageSlider.value = 0.15
        
         maxPercentageSlider.value = 0.30
         
         minPercentageLabel.text = String(format: "%.2f%%", minPercentageSlider.value * 100.0)
         
         maxPercentageLabel.text = String(format: "%.2f%%", maxPercentageSlider.value * 100.0)
        
        
    }
    
    func enableResetButton() {
        
        restoreDefaults.isEnabled = true
        
        restoreDefaults.backgroundColor = UIColor(red: 0.1333, green: 0.4392, blue: 0.5765, alpha: 1.0)

        restoreDefaults.setTitleColor(UIColor(red: 209.0/255.0, green: 204.0/255.0, blue: 192.0/255.0, alpha: 1.0) , for: .disabled)
        
    }
    
    func disableResetButton() {
        
        restoreDefaults.isEnabled = false
        
        restoreDefaults.backgroundColor = UIColor(red: 209.0/255.0, green: 204.0/255.0, blue: 192.0/255.0, alpha: 1.0)
        
        restoreDefaults.setTitleColor(UIColor(red: 0.1333, green: 0.4392, blue: 0.5765, alpha: 1.0) , for: .disabled)
        
    }
    
    func showNotification(withTitle title: String,withMessage message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
        
    }
    
    
    @IBAction func saveTipValuesTapped(_ sender: UIButton) {
        
        let defaults = UserDefaults.standard
        
        defaults.set(minPercentageSlider.value, forKey: "minVal")
        
        defaults.set(maxPercentageSlider.value, forKey: "maxVal")
        
        showNotification(withTitle: "Success", withMessage: "Your new Max and Min tip values were saved")
        
        enableResetButton()
        
    }
    
    
    @IBAction func minTipSliderHandler(_ sender: Any) {
    
        
        if minPercentageSlider.value > maxPercentageSlider.value {
            
            maxPercentageSlider.value = minPercentageSlider.value
            
            minPercentageLabel.text = String(format: "%.2f%%", minPercentageSlider.value * 100.0)

            
        } else {
            
            minPercentageLabel.text = String(format: "%.2f%%", minPercentageSlider.value * 100.0)
            
        }

    }
    
    @IBAction func maxTipSliderHandler(_ sender: Any) {
                
        if maxPercentageSlider.value > minPercentageSlider.value {
            
            maxPercentageLabel.text = String(format: "%.2f%%", maxPercentageSlider.value * 100.0)
        
        } else {
            
            maxPercentageSlider.value = minPercentageSlider.value
            maxPercentageLabel.text = String(format: "%.2f%%", maxPercentageSlider.value * 100.0)

            
            return
            
        }
        
    }
    
    
    @IBAction func restoreDefaultsTapped(_ sender: UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "maxVal")
        
        UserDefaults.standard.removeObject(forKey: "minVal")
        
        showNotification(withTitle: "Success", withMessage: "Min and Max tip values were restored to default")
        
        disableResetButton()
        
        setupView()
        
    }
    
}


