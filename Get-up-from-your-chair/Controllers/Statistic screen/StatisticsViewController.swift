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
  
//  private lazy var placeHolder: UILabel = {
//    let label = UILabel()
//    label.text = "Тут будет статистика"
//    label.font = .systemFont(ofSize: 40, weight: .semibold)
//    label.numberOfLines = 2
//    label.textAlignment = .center
//    return label
//  }()
  
//  private lazy var graphView: GraphView = {
//    let width:CGFloat = 300.0
//    let x = self.view.frame.width / 2 - width / 2
//    let frame = CGRect(x: x, y: 150, width: width, height: 250)
//    let view = GraphView(frame: frame)
//    view.backgroundColor = .clear
//    return view
//  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
//    setupConstraints()
  }
  
//  private func setupConstraints() {
////    graphView.translatesAutoresizingMaskIntoConstraints = false
//    view.addSubview(graphView)
//
//    NSLayoutConstraint.activate([
//      graphView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//      graphView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//      graphView.widthAnchor.constraint(equalToConstant: 300)
//    ])
//  }
}
