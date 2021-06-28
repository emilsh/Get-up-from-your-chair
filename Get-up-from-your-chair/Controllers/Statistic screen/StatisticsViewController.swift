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
    
    view.backgroundColor = .white
  }
  

}
