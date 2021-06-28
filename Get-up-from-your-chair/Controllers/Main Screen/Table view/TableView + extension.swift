//
//  TableView + extension.swift
//  Get-up-from-your-chair
//
//  Created by Sergey on 28.06.2021.
//

import UIKit


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
