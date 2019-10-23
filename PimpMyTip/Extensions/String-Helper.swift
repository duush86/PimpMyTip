//
//  String-Helper.swift
//  PimpMyTip
//
//  Created by Antonio Orozco on 10/21/19.
//  Copyright © 2019 Antonio Orozco. All rights reserved.
//

import Foundation
import UIKit

extension String {
   
    var currency: String {
        
        // removing all characters from string before formatting
        let stringWithoutSymbol = self.replacingOccurrences(of: "$", with: "")
        
        let stringWithoutComma = stringWithoutSymbol.replacingOccurrences(of: ",", with: "")

        let styler = NumberFormatter()
        
        styler.minimumFractionDigits = 0
        
        styler.maximumFractionDigits = 0
        
        styler.currencySymbol = "$"
        
        styler.numberStyle = .currency

        if let result = NumberFormatter().number(from: stringWithoutComma) {
        
            return styler.string(from: result)!
        
        }

        return self
    
    }
    
    var percent: String {
        
        // removing all characters from string before formatting
        let stringWithoutSymbol = self.replacingOccurrences(of: "$", with: "")
        
        let stringWithoutPoint = stringWithoutSymbol.replacingOccurrences(of: ".", with: "")

        let stringWithoutComma = stringWithoutPoint.replacingOccurrences(of: ",", with: "")

        let styler = NumberFormatter()

        styler.minimum = 0
        
        styler.maximum = 100
        
        styler.maximumFractionDigits = 3
        
        styler.minimumFractionDigits = 3 
        
        styler.percentSymbol = "%"

        styler.numberStyle = .decimal
        
        let amountWithPrefix = stringWithoutComma
        
        var number: NSNumber!
        
        let double = (amountWithPrefix as NSString).doubleValue
        
        number = NSNumber(value: (double / 1000))

        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return "\(styler.string(from: number)!)%"
    
    }

}



extension StringProtocol {
    
    var double: Double? {
    
        return Double(self)
    
    }
    
    var float: Float? {
    
        return Float(self)
    
    }
    
    var integer: Int? {
    
        return Int(self)
    
    }
    
//    func image() -> UIImage? {
//        let size = CGSize(width: 40, height: 40)
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        UIColor.white.set()
//        let rect = CGRect(origin: .zero, size: size)
//        UIRectFill(CGRect(origin: .zero, size: size))
//        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image
//    }
    
}
