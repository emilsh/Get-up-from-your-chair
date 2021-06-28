//
//  ViewController.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 23/6/21.
//

import UIKit

class ActivityViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var buttonBackgroundView: UIView!
  @IBOutlet weak var playPauseButton: UIButton!
  @IBOutlet weak var playPauseLabel: UILabel!
  @IBOutlet weak var nextNotificationLabel: UILabel!
  @IBOutlet weak var nextNotificationTextLabel: UILabel!
  
  // текущая карточка активности
  var currentCard = 0
  
  var isRunning: Bool! = false
  var duration: TimeInterval {
    get {
      return getDuration()
    }
    set{
      storeDuration(newValue)
    }
  }
  var dailyTasks: [Task]! {
    get {
      realm.fetchDailyTasks(for: Date().timeIntervalSince1970).sorted { task1, task2 in
        task1.endDate > task2.endDate
      }
    }
  }
  let realm = RealmService.shared
  
  lazy var formatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateStyle = .none
      formatter.timeStyle = .short
      formatter.locale = Locale(identifier: "ru_RU")
      return formatter
    }()
  
  private var sectionInsets: UIEdgeInsets = {
    let spacing: CGFloat = 20
    let sectionInsets = UIEdgeInsets(
      top:    spacing,
      left:   spacing,
      bottom: spacing,
      right:  spacing)
    return sectionInsets
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    registerDefaultDuration()
    
    UNUserNotificationCenter.current().delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateUI()
  }
  
  private func setupUI() {
    buttonBackgroundView.backgroundColor = .white
    buttonBackgroundView.layer.shadowColor = UIColor.black.cgColor
    buttonBackgroundView.layer.shadowOpacity = 0.5
    buttonBackgroundView.layer.shadowOffset = .zero
    buttonBackgroundView.layer.shadowRadius = 5
    buttonBackgroundView.layer.cornerRadius = 15
    buttonBackgroundView.layer.shadowPath = UIBezierPath(
      roundedRect: buttonBackgroundView.bounds,
      cornerRadius: buttonBackgroundView.layer.cornerRadius).cgPath
  }
  
  func updatePlayButtonImage() {
    let imageName = isRunning ? "pause.fill" : "play.fill"
    playPauseLabel.text = isRunning ? "Остановить" : "Продолжить"
    playPauseButton.setImage(UIImage(systemName: imageName), for: .normal)
  }
  
  func updateNextNotificationLabel(with endDate: TimeInterval) {
    nextNotificationLabel.text = isRunning ? getHoursMinutes(from: endDate) : "остановлены"
    nextNotificationTextLabel.text = isRunning ? "Следующее:" : "Уведомления"
    nextNotificationLabel.textColor = isRunning ? .black : .gray
    nextNotificationTextLabel.textColor = isRunning ? .black : .gray
  }
  
  func updateUI() {
    guard let task = realm.getLastTask() else {
      isRunning = false
      return
    }
    isRunning = getApplicationState()
    updatePlayButtonImage()
    updateNextNotificationLabel(with: task.endDate)
  }
}
