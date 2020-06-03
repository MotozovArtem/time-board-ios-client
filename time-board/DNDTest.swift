//
//  DNDTest.swift
//  time-board
//
//  Created by Tianid on 03.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class DNDTest: UIViewController {
    @IBOutlet weak var tableViewOne: UITableView!
    @IBOutlet weak var tableViewTwo: UITableView!
    
    private let cellID = "CellID"
    
    let tableViewOneModels = TaskDataSource(models: [1,2,3,4,5,6,7,8,9,0])
    let tableViewTwoModels = TaskDataSource(models: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOne.register(UINib(nibName: "TaskContainerTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableViewTwo.register(UINib(nibName: "TaskContainerTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        tableViewOne.dragInteractionEnabled = true
        tableViewTwo.dragInteractionEnabled = true
        
        for tableView in [tableViewOne, tableViewTwo] {
            if let tableView = tableView {
                tableView.dataSource = dataSourceForTableView(tableView)
                tableView.dragDelegate = self
                tableView.dropDelegate = self
                tableView.reloadData()
            }
        }
        
    }
    
    func dataSourceForTableView(_ tableView: UITableView) -> TaskDataSource {
        if (tableView == tableViewOne) {
            return tableViewOneModels
        } else {
            return tableViewTwoModels
        }
    }
}

extension DNDTest: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dataSource = dataSourceForTableView(tableView)
        session.localContext = (dataSource, indexPath, tableView)
        return dataSource.dragItems(for: indexPath)
    }
}

extension DNDTest: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        
        if tableView.hasActiveDrag {
            if session.items.count > 1 {
                return UITableViewDropProposal(operation: .cancel)
            } else {
                return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        } else {
            return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
    }
    
    func removeSourceTableData(localContext: Any?) {
        if let (dataSource, sourceIndexPath, tableView) = localContext as? (TaskDataSource, IndexPath, UITableView) {
            tableView.beginUpdates()
            dataSource.models.remove(at: sourceIndexPath.row)
            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let dataSource = dataSourceForTableView(tableView)
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        for item in coordinator.items {
            if let sourceIndexPath = item.sourceIndexPath {
                print("SAME table view")
                dataSource.moveItem(at: sourceIndexPath.row, to: destinationIndexPath.row)
                DispatchQueue.main.async {
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [sourceIndexPath], with: .none)
                    tableView.insertRows(at: [destinationIndexPath], with: .none)
                    tableView.endUpdates()
                }
            } else if let model = item.dragItem.localObject as? Int {
                print("Different table")
                DispatchQueue.main.async {
                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                    dataSource.addModel(model, at: destinationIndexPath.row)
                    tableView.insertRows(at: [destinationIndexPath], with: .none)
                    
                }
            }
            
        }
    }
    
    
}
