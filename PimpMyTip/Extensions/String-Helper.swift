//
//  String-Helper.swift
//  PimpMyTip
//
//  Created by Antonio Orozco on 10/21/19.
//  Copyright © 2019 Antonio Orozco. All rights reserved.
//

import Foundation

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
}
