//
//  Double+Extension.swift
//  sph-assignment
//
//  Created by Kelvin Fok on 25/6/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation

extension Double {
    
    func rounded(toDecimalPlaces n: Int) -> Double {
        return Double(String(format: "%.\(n)f", self))!
    }
}
