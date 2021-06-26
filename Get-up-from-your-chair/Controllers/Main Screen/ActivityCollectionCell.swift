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
  
  func setButtonInteraction() {
    let interaction = UIContextMenuInteraction(delegate: self)
    timeIntervalButton.addInteraction(interaction)
//    timeIntervalButton.showsMenuAsPrimaryAction = true
  }
  
  @IBAction func timeIntervalButtonPressed() {
    
//    let fifteenImage = UIImage(systemName: "goforward.15")
//    let setMinutes15 = UIAction(
//      title: "Каждые 15 мин",
//      image: fifteenImage,
//      identifier: .none,
//      state: .off) { action in
//      // TODO: set timeInterval
//    }
//
//    let thirtyImage = UIImage(systemName: "goforward.30")
//    let setMinutes30 = UIAction(
//      title: "Каждые 30 мин",
//      image: thirtyImage,
//      identifier: .none,
//      state: .on) { action in
//      // TODO: set timeInterval
//    }
//
//    let sixtyImage = UIImage(systemName: "goforward.60")
//    let setMinutes60 = UIAction(
//      title: "Каждые 60 мин",
//      image: sixtyImage,
//      identifier: .none,
//      state: .off) { action in
//      // TODO: set timeInterval
//    }
//
//    let ninetyImage = UIImage(systemName: "goforward.15")
//    let setMinutes90 = UIAction(
//      title: "Каждые 90 мин",
//      image: ninetyImage,
//      identifier: .none,
//      state: .off) { action in
//      // TODO: set timeInterval
//    }
//
//    timeIntervalButton.menu = UIMenu(
//      title: "Интервал уведомлений",
//      children: [setMinutes15, setMinutes30, setMinutes60, setMinutes90])
//    timeIntervalButton.showsMenuAsPrimaryAction = true
  }
  
}

extension ActivityCollectionCell: UIContextMenuInteractionDelegate {
  func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
    let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions in
      
      let fifteenImage = UIImage(systemName: "goforward.15")
      let setMinutes15 = UIAction(
        title: "Каждые 15 мин",
        image: fifteenImage,
        identifier: .none,
        state: .off) { action in
        // TODO: set timeInterval
      }
      
      let thirtyImage = UIImage(systemName: "goforward.30")
      let setMinutes30 = UIAction(
        title: "Каждые 30 мин",
        image: thirtyImage,
        identifier: .none,
        state: .on) { action in
        // TODO: set timeInterval
      }
      
      let sixtyImage = UIImage(systemName: "goforward.60")
      let setMinutes60 = UIAction(
        title: "Каждые 60 мин",
        image: sixtyImage,
        identifier: .none,
        state: .off) { action in
        // TODO: set timeInterval
      }
      
      let ninetyImage = UIImage(systemName: "goforward.15")
      let setMinutes90 = UIAction(
        title: "Каждые 90 мин",
        image: ninetyImage,
        identifier: .none,
        state: .off) { action in
        // TODO: set timeInterval
      }
      
      return UIMenu(title: "", options: [], children: [setMinutes15, setMinutes30, setMinutes60, setMinutes90])
    }
    return configuration
    
  }
}
