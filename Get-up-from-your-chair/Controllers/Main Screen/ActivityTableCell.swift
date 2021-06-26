//
//  ActivityTableCell.swift
//  Get-up-from-your-chair
//
//  Created by Sergey on 24.06.2021.
//

import UIKit

class ActivityTableCell: UITableViewCell {

  static let reuseIdentifer = String(describing: ActivityTableCell.self)
  
  @IBOutlet weak var activityImage: UIImageView!
  @IBOutlet weak var doneImage: UIImageView!
  @IBOutlet weak var activityDateLabel: UILabel!
  @IBOutlet weak var doneLabel: UILabel!
  
  private lazy var formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    formatter.locale = Locale(identifier: "ru_RU")
    return formatter
  }()
  
  func configure(with task: Task) {
    
    var image = UIImage(systemName: "nosign")
    if let imageData = task.activity?.image {
      image = UIImage(data: imageData)
    }
    activityImage.image = image

    if task.isDone {
      doneImage.image = UIImage(systemName: "checkmark.circle")
      doneLabel.text = "Выполнено"
    } else {
      doneImage.image = UIImage(systemName: "circle")
      doneLabel.text = ""
    }
//    let taskDate = Date().addingTimeInterval(task.endDate)
    let taskDate = Date(timeIntervalSince1970: task.endDate)
    activityDateLabel.text = formatter.string(from: taskDate)
  }
}
