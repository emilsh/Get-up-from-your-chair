//
//  ViewController.swift
//  Get-up-from-your-chair
//
//  Created by Emil Shafigin on 23/6/21.
//

import UIKit

class ActivityViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var buttonBackgroundView: UIView!
  @IBOutlet weak var playPauseButton: UIButton!
  @IBOutlet weak var nextNotificationLabel: UILabel!
  
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
    let task = Task(activity: activity, isDone: true, date: 3424234234, duration: 423442525)
    
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
    return 54
  }
}

// MARK: - Collection DataSource
extension ActivityViewController: UICollectionViewDataSource {
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
    
    return 2
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ActivityCollectionCell.reuseIdentifer,
            for: indexPath) as? ActivityCollectionCell else {
      fatalError("can't dequeue ActivityCollectionCell")
    }
    cell.setupUI()
    return cell
  }
  
  
}

// MARK: - Collection Delegate
extension ActivityViewController: UICollectionViewDelegate {
  
}

// MARK: - Flow Layout
extension ActivityViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {

    let paddingSpace = sectionInsets.left * 2
    let availableWidth = view.frame.width - paddingSpace
    let heightPerItem: CGFloat = 350
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
