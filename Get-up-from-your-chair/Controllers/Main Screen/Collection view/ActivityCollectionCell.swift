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
    
    let imageConfig  = UIImage.SymbolConfiguration(textStyle: .title2)
    let fifteenImage = UIImage(systemName: "goforward.15", withConfiguration: imageConfig)
    let thirtyImage  = UIImage(systemName: "goforward.30", withConfiguration: imageConfig)
    let sixtyImage   = UIImage(systemName: "goforward.60", withConfiguration: imageConfig)
    let ninetyImage  = UIImage(systemName: "goforward.90", withConfiguration: imageConfig)
    
    let setByUserTime = getDuration()
    switch setByUserTime {
    case Duration.fifteen.rawValue: timeIntervalButton.setImage(fifteenImage, for: .normal)
    case Duration.thirty.rawValue: timeIntervalButton.setImage(thirtyImage, for: .normal)
    case Duration.sixty.rawValue: timeIntervalButton.setImage(sixtyImage, for: .normal)
    case Duration.ninety.rawValue: timeIntervalButton.setImage(ninetyImage, for: .normal)
    default: timeIntervalButton.setImage(sixtyImage, for: .normal)
    }
  }
  
  func setButtonInteraction() {
    let interaction = UIContextMenuInteraction(delegate: self)
    timeIntervalButton.addInteraction(interaction)
//    timeIntervalButton.showsMenuAsPrimaryAction = true
  }
  
  @IBAction func timeIntervalButtonPressed() {}
  
  func configure(with activity: Activity) {
    if let dataImage = activity.image {
      let activityImage = UIImage(data: dataImage)?.withTintColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
      activityImageView.image = activityImage
    }
    
    activityNameLabel.text = activity.name
    activityDescriptionLabel.text = activity.activityDescription
  }
  
  func reloadTableView() {
    let collectionView = self.superview as? UICollectionView
    collectionView?.reloadData()
  }
}

extension ActivityCollectionCell: UIContextMenuInteractionDelegate {
  func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
    let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions in
      
      let imageConfig  = UIImage.SymbolConfiguration(textStyle: .title2)
      let fifteenImage = UIImage(systemName: "goforward.15", withConfiguration: imageConfig)
      let thirtyImage  = UIImage(systemName: "goforward.30", withConfiguration: imageConfig)
      let sixtyImage   = UIImage(systemName: "goforward.60", withConfiguration: imageConfig)
      let ninetyImage  = UIImage(systemName: "goforward.90", withConfiguration: imageConfig)
      
      let setMinutes15 = UIAction(
        title: "Каждые 15 мин",
        image: fifteenImage,
        identifier: .none,
        state: getDuration() == Duration.fifteen.rawValue ? .on : .off)
      { action in
        storeDuration(Duration.fifteen.rawValue)
        self.timeIntervalButton.setImage(fifteenImage, for: .normal)
        self.reloadTableView()
      }
      
      let setMinutes30 = UIAction(
        title: "Каждые 30 мин",
        image: thirtyImage,
        identifier: .none,
        state: getDuration() == Duration.thirty.rawValue ? .on : .off)
      { action in
        storeDuration(Duration.thirty.rawValue)
        self.timeIntervalButton.setImage(thirtyImage, for: .normal)
        self.reloadTableView()
      }
      
      let setMinutes60 = UIAction(
        title: "Каждые 60 мин",
        image: sixtyImage,
        identifier: .none,
        state: getDuration() == Duration.sixty.rawValue ? .on : .off)
      { action in
        storeDuration(Duration.sixty.rawValue)
        self.timeIntervalButton.setImage(sixtyImage, for: .normal)
        self.reloadTableView()
      }
      
      let setMinutes90 = UIAction(
        title: "Каждые 90 мин",
        image: ninetyImage,
        identifier: .none,
        state: getDuration() == Duration.ninety.rawValue ? .on : .off)
      { action in
        storeDuration(Duration.ninety.rawValue)
        self.timeIntervalButton.setImage(ninetyImage, for: .normal)
        self.reloadTableView()
      }

      let menu = UIMenu(
        title: "",
        options: [],
        children: [setMinutes15, setMinutes30, setMinutes60, setMinutes90])
      return menu
    }
    return configuration
    
  }
}
