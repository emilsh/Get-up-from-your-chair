//
//  ViewController.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 23/6/21.
//

import UIKit

class ActivityViewController: UIViewController {
  
  var isRunning: Bool!
  var task: Task?
  var duration: TimeInterval!
  var dailyTasks: [Task]!

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var playButton: UIButton!
  
  private lazy var formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    formatter.locale = Locale(identifier: "ru_RU")
    return formatter
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //MARK: Actions
  @IBAction func playButtonTapped(_ sender: Any) {
    if !isRunning {
      let currentActivity = ActivityData.activities[0] // TODO: change to choose activity from cards
      let startDate = Date().timeIntervalSince1970
      let endDate = startDate + duration
      task = Task(activity: currentActivity, isDone: false, startDate: startDate, endDate: endDate)
      task?.scheduleNotification()
      
      timeLabel.text = hoursMinutesToString(from: endDate)
      playButton.setImage(UIImage(systemName: ""), for: .normal) // TODO: UIImage(systemName:) change argument to "pause image"
      isRunning = !isRunning
    } else {
      task?.removeNotification()
      
      playButton.setImage(UIImage(systemName: ""), for: .normal) // TODO: UIImage(systemName:) change argument to "play image"
      isRunning = !isRunning
    }
  }
  
  //MARK: - Helper methods
  func hoursMinutesToString(from date: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: date)
    return formatter.string(from: date)
  }
}

// MARK: - Table DataSource
extension ActivityViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ActivityTableCell.reuseIdentifer,
            for: indexPath) as? ActivityTableCell else {
      fatalError("custom table view cell error")
    }
    let image = UIImage(systemName: "figure.walk")?.pngData()
    let activity = Activity(name: "Отжаться 20 раз", image: image, description: "")
    let task = Task(activity: activity, isDone: true, startDate: 3424234234, endDate: 423442525)
    
    cell.configure(with: task)
    return cell
  }
  
  
}

// MARK: - Table Delegate
extension ActivityViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 72
  }
}
