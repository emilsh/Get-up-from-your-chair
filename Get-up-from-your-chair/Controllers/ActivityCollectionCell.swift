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
}
