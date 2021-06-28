//
//  CollectionView + extension.swift
//  Get-up-from-your-chair
//
//  Created by Sergey on 28.06.2021.
//

import UIKit


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

// MARK: - Current Card Index
extension ActivityViewController {

  func getCurrentCard() -> Int {
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
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

    return sectionInsets.left
  }
}
