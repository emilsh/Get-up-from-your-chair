//
//  ActivityCollectionCell.swift
//  Get-up-from-your-chair
//
//  Created by Sergey on 25.06.2021.
//

import UIKit

class ActivityCollectionCell: UICollectionViewCell {
  static let reuseIdentifer = String(describing: ActivityCollectionCell.self)
  
  @IBOutlet weak var timeIntervalButton: UIButton!
  @IBOutlet weak var activityImageView: UIImageView!
  @IBOutlet weak var activityNameLabel: UILabel!
  @IBOutlet weak var activityDescriptionLabel: UILabel!
  
  func setupUI() {
    layer.cornerRadius = 25
    
    timeIntervalButton.layer.shadowColor = UIColor.black.cgColor
    timeIntervalButton.layer.shadowOpacity = 0.5
    timeIntervalButton.layer.shadowOffset = .zero
    timeIntervalButton.layer.shadowRadius = 5
    
    timeIntervalButton.layer.cornerRadius = 10
    timeIntervalButton.layer.shadowPath = UIBezierPath(
      roundedRect: timeIntervalButton.bounds,
      cornerRadius: timeIntervalButton.layer.cornerRadius).cgPath
    
  }
}
