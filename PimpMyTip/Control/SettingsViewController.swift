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
    
    override func viewDidLoad() {
 
        super.viewDidLoad()
        
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setupView()
        
    }
    
    func setupView(){
        
        guard let minValue = UserDefaults.standard.object(forKey: "minVal") as? Float else {
               
               return
               
           }
           
           guard let maxValue = UserDefaults.standard.object(forKey: "maxVal") as? Float else {
               
               return
               
           }
           
        minPercentageSlider.value = minValue
        
        minPercentageLabel.text = String(format: "%.2f%%", minPercentageSlider.value * 100.0)

        
        maxPercentageSlider.value = maxValue
        
        maxPercentageLabel.text = String(format: "%.2f%%", maxPercentageSlider.value * 100.0)

        
    }
    
    
    @IBAction func saveTipValuesTapped(_ sender: UIButton) {
        
        let defaults = UserDefaults.standard
        
        defaults.set(minPercentageSlider.value, forKey: "minVal")
        
        defaults.set(maxPercentageSlider.value, forKey: "maxVal")
        
        let alert = UIAlertController(title: "Success!", message: "Your new max and min values were saved", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        //alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
        
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
    
}


