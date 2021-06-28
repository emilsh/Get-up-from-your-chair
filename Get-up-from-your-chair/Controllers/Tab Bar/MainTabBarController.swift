//
//  MainTabBarController.swift
//  Get-up-from-your-chair
//
//  Created by Sergey on 24.06.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addViewControllers()
    setupUI()
  }
  
  private func setupUI() {
    UITabBar.appearance().tintColor = .black
    UINavigationBar.appearance().prefersLargeTitles = true
  }
}

// MARK: - View Controller Stack
extension MainTabBarController {
  
  private func createStatisticsVC() -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let mainVC = storyboard.instantiateViewController(
            withIdentifier: "StatisticsViewController") as? StatisticsViewController else {
      fatalError("StatisticsVC doesn't exist")
    }
    let statisticsVC = UINavigationController(rootViewController: mainVC)
    statisticsVC.tabBarItem.title = "Статистика"
    statisticsVC.tabBarItem.image = UIImage(systemName: "waveform.path.ecg.rectangle")
    return statisticsVC
  }
  
  private func createActivityVC() -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let mainVC = storyboard.instantiateViewController(
            withIdentifier: "ActivityViewController") as? ActivityViewController else {
      fatalError("activity VC doesn't exist")
    }
    let activityVC = UINavigationController(rootViewController: mainVC)
    activityVC.tabBarItem.title = "Активности"
    activityVC.tabBarItem.image = UIImage(systemName: "clock.arrow.2.circlepath")
    activityVC.navigationBar.topItem?.title = " Встань уже со стула!"
    return activityVC
  }
  
  private func addViewControllers() {
    let activityVC = createActivityVC()
    let statisticsVC = createStatisticsVC()
    viewControllers = [activityVC, statisticsVC]
  }
}
