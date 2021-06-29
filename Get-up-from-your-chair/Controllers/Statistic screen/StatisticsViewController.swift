//
//  StatisticsViewController.swift
//  Get-up-from-your-chair
//
//  Created by Sergey on 24.06.2021.
//

import UIKit

class StatisticsViewController: UIViewController {
  
  @IBOutlet weak var graphView: GraphView!
  @IBOutlet weak var averageActivities: UILabel!
  @IBOutlet weak var maxLabel: UILabel!
  @IBOutlet weak var stackView: UIStackView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    view.backgroundColor = .white
    setupGraphDisplay()
  }
  
  func setupGraphDisplay() {
    let maxDayIndex = stackView.arrangedSubviews.count - 1
   
    graphView.setNeedsDisplay()
    maxLabel.text = "\(graphView.graphPoints.max() ?? 0)"
    
    let average = graphView.graphPoints.reduce(0,+) / graphView.graphPoints.count
    averageActivities.text = "\(average)"
    
    let today = Date()
    let calendar = Calendar.current
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ru_RU")
    formatter.setLocalizedDateFormatFromTemplate("EEEEE")
    
    for i in 0...maxDayIndex {
      if let date = calendar.date(byAdding: .day, value: -i, to: today),
         let label = stackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
        label.text = formatter.string(from: date)
      }
    }
  }
  

}
