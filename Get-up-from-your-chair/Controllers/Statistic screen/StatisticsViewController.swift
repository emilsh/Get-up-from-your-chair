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
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    graphView.activities = getActivitiesForWeek()
    setupGraphDisplay()
  }
  
  func getActivitiesForWeek() -> [Int] {
    var weeklyActivities: [Int] = []
    for day in DaysAgo.allCases {
      let count = RealmService.shared.getCountOfActivities(for: day.rawValue)
      weeklyActivities.append(count)
    }
    return weeklyActivities
  }
  
  func setupGraphDisplay() {
    let maxDayIndex = stackView.arrangedSubviews.count - 1
   
    graphView.setNeedsDisplay()
    maxLabel.text = "\(graphView.activities.max() ?? 0)"
    
    let average = graphView.activities.reduce(0,+) / graphView.activities.count
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
