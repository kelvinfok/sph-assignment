//
//  YearlyRecordTableViewCell.swift
//  sph-assignment
//
//  Created by Kelvin Fok on 25/6/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

class YearlyRecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var didDecreaseImageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var consumptionLabel: UILabel!
    
    var didTapOnImageObserver: ((_ year: Int) -> Void)?
    
    var yearlyRecord: YearlyRecord? {
        willSet {
            setupViews()
        }
        didSet {
            updateViews()
        }
    }
    
    private func setupViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnImage))
        didDecreaseImageView.addGestureRecognizer(tapGesture)
    }
    
    private func updateViews() {
        if let year = self.yearlyRecord?.year {
            yearLabel.text = "\(year)"
        }
        if let consumption = self.yearlyRecord?.q1 {
            consumptionLabel.text = "\(consumption)"
        }
    }
    
    @objc private func didTapOnImage() {
        if let year = self.yearlyRecord?.year {
            self.didTapOnImageObserver?(year)
        }
    }
    
    
}
