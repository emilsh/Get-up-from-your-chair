//
//  ViewController.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 23/6/21.
//

import UIKit

class ActivityViewController: UIViewController {
  
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

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var buttonBackgroundView: UIView!
  @IBOutlet weak var playPauseButton: UIButton!
  @IBOutlet weak var playPauseLabel: UILabel!
  @IBOutlet weak var nextNotificationLabel: UILabel!
  @IBOutlet weak var nextNotificationTextLabel: UILabel!
  
  private var sectionInsets: UIEdgeInsets = {
    let spacing: CGFloat = 20
    let sectionInsets = UIEdgeInsets(
      top:    spacing,
      left:   spacing,
      bottom: spacing,
      right:  spacing)
    return sectionInsets
  }()
  
  // текущая карточка активности
  private var currentCard = 0
  
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
}

// MARK: - Table DataSource
extension ActivityViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let dailyTasks =  dailyTasks else {
      return 0
    }
    return dailyTasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ActivityTableCell.reuseIdentifer,
            for: indexPath) as? ActivityTableCell else {
      fatalError("custom table view cell error")
    }
    let task = dailyTasks[indexPath.row]
    
    cell.configure(with: task)
    return cell
  }
  
  
}

// MARK: - Table Delegate
extension ActivityViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let task = dailyTasks[indexPath.row]
    realm.toggleState(for: task)
    tableView.reloadRows(at: [indexPath], with: .automatic)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 54
  }
  
  func tableView(
    _ tableView: UITableView,
    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
  ) -> UISwipeActionsConfiguration? {
    let task = dailyTasks[indexPath.row]
    let isDoneAction = UIContextualAction(style: .normal, title: "Сделано") { (_, _, _) in
      
      self.realm.markTaskDone(task)
      tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    isDoneAction.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
    let configuration = UISwipeActionsConfiguration(actions: [isDoneAction])
    configuration.performsFirstActionWithFullSwipe = true
    return configuration
  }
  
  func tableView(
    _ tableView: UITableView,
    leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
  ) -> UISwipeActionsConfiguration? {
    let task = dailyTasks[indexPath.row]
    let isNotDoneAction = UIContextualAction(style: .normal, title: "Пропустить") { (_, _, _) in
      
      self.realm.markTaskUnDone(task)
      tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    isNotDoneAction.backgroundColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
    let configuration = UISwipeActionsConfiguration(actions: [isNotDoneAction])
    configuration.performsFirstActionWithFullSwipe = true
    return configuration
  }
  
  // MARK: - оно нам надо или нет?
  func tableView(
    _ tableView: UITableView,
    contextMenuConfigurationForRowAt indexPath: IndexPath,
    point: CGPoint) -> UIContextMenuConfiguration? {
    
    let task = dailyTasks[indexPath.row]
    let actionTitle = task.isDone ? "Отметить пропущенным" : "Отметить выполненным"
    let image = UIImage(systemName: task.isDone ? "circle" : "checkmark.circle")
    let taskTitle = task.activity?.name ?? "активность"
    
    let configuaration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { element in
      let action = UIAction(
        title: actionTitle,
        image: image,
        identifier: .none,
        discoverabilityTitle: nil,
        attributes: [], state: .off) { action in
        
        self.realm.toggleState(for: task)
        tableView.reloadRows(at: [indexPath], with: .automatic)
      }
      return UIMenu.init(title: taskTitle, options: [], children: [action])
    }
    return configuaration
  }

}

// MARK: - Collection DataSource
extension ActivityViewController: UICollectionViewDataSource {
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
    
    return ActivityData.activities.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ActivityCollectionCell.reuseIdentifer,
            for: indexPath) as? ActivityCollectionCell else {
      fatalError("can't dequeue ActivityCollectionCell")
    }
    let activity = ActivityData.activities[indexPath.item]
    cell.setupUI()
    cell.setButtonInteraction()
    cell.configure(with: activity)
    return cell
  }
  
  
}

// MARK: - Current Card Index
extension ActivityViewController {

  private func getCurrentCard() -> Int {
    let origin = collectionView.contentOffset
    let collectionSize = collectionView.bounds.size
    let visibleRect = CGRect(origin: origin, size: collectionSize)
    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
      return visibleIndexPath.row
    }
    return currentCard
  }
}

// MARK: - Collection Delegate
extension ActivityViewController: UICollectionViewDelegate {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    currentCard = getCurrentCard()
    print("\(#function), card index: \(currentCard)")
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    currentCard = getCurrentCard()
    print("\(#function), card index: \(currentCard)")

  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    currentCard = getCurrentCard()
    print("\(#function), card index: \(currentCard)")

  }
}

// MARK: - Flow Layout
extension ActivityViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {

    let paddingSpace = sectionInsets.left * 2
    let availableWidth = view.frame.width - paddingSpace
    let heightPerItem: CGFloat = 300
    return CGSize(width: availableWidth, height: heightPerItem)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int) -> UIEdgeInsets {

    return sectionInsets
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int) -> CGFloat {

    return sectionInsets.left
  }
}
