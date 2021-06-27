//
//  StatisticsViewController.swift
//  Get-up-from-your-chair
//
//  Created by Sergey on 24.06.2021.
//

import UIKit

class StatisticsViewController: UIViewController {
  
  private lazy var placeHolder: UILabel = {
    let label = UILabel()
    label.text = "Тут будет статистика"
    label.font = .systemFont(ofSize: 40, weight: .semibold)
    label.numberOfLines = 2
    label.textAlignment = .center
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    setupConstraints()
  }
  
  private func setupConstraints() {
    placeHolder.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(placeHolder)
    
    NSLayoutConstraint.activate([
      placeHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      placeHolder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      placeHolder.widthAnchor.constraint(equalToConstant: 300)
    ])
  }
}
