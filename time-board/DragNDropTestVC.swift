//
//  DragNDropTestVC.swift
//  time-board
//
//  Created by Tianid on 03.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit


class DragNDropTestVC: UIViewController {
    
    @IBOutlet weak var tableViewOne: UITableView!
    @IBOutlet weak var tableViewTwo: UITableView!
    
    var numbers = ["1", "2", "3", "4", "5","6", "7", "8", "9", "0"]
    var alpabets = ["A", "B", "C", "D", "E","F", "G", "H", "I", "J"]
    
    private var cellId = "CellID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOne.backgroundColor = .red
        tableViewTwo.backgroundColor = .green
        
        tableViewOne.register(UINib(nibName: "TaskContainerTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellId)
        tableViewTwo.register(UINib(nibName: "TaskContainerTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellId)
        
        tableViewOne.dragInteractionEnabled = true
        tableViewTwo.dragInteractionEnabled = true
        
        tableViewOne.dragDelegate = self
        tableViewTwo.dragDelegate = self
        
        tableViewOne.dropDelegate = self
        tableViewTwo.dropDelegate = self
        
        tableViewOne.dataSource = self
        tableViewTwo.dataSource = self
        
        tableViewOne.tag = 1
        tableViewTwo.tag = 2
        // Do any additional setup after loading the view.
    }
    
}

extension DragNDropTestVC: UITableViewDragDelegate, UITableViewDataSource, UITableViewDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 1:
            return numbers.count
        case 2:
            return alpabets.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TaskContainerTableViewCell
        switch tableView.tag {
        case 1:
            cell.taskDescriptionLabel.text = numbers[indexPath.row]
        case 2:
            cell.taskDescriptionLabel.text = alpabets[indexPath.row]
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    //MARK: - Dran And Drop functions

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = self.dragItem(forItemAt: indexPath, tableView: tableView)
        return [dragItem]
    }
    
    private func dragItem(forItemAt indexPath: IndexPath, tableView: UITableView) -> UIDragItem {
        var value = ""
        switch tableView.tag {
        case 1:
            value = numbers[indexPath.row]
        case 2:
            value = alpabets[indexPath.row]
        default:
            value = ""
        }
        
        let itemProvider = NSItemProvider(object: value as NSItemProviderWriting)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return dragItem
    }
    
    func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        return previewParameters(forItem: indexPath, tableView: tableView)
    }
    
    private func previewParameters(forItem indexPath: IndexPath, tableView: UITableView) -> UIDragPreviewParameters? {
        let cell = tableView.cellForRow(at: indexPath) as! TaskContainerTableViewCell
        let previewParameters = UIDragPreviewParameters()
        previewParameters.visiblePath = UIBezierPath(rect: cell.contentView.frame)
        return previewParameters
    }
    
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
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
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
                    tableView.insertRows(at: [destinationIndexPath], with: .automatic)
                }

            }

        }
        
//        coordinator.session.loadObjects(ofClass: NSString.self) { (items) in
//            guard let string = items as? [String] else { return }
//            var indexPaths = [IndexPath]()
//            for (index, value) in string.enumerated() {
//                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
//                switch tableView.tag {
//                case 2:
//                    self.alpabets.insert(value, at: indexPath.row)
//                    if self.numbers.contains(value) {
//                        self.numbers = self.numbers.filter({ $0 != value })
//                        self.tableViewOne.reloadData()
//                    } else {
//                        print("ELSE tag 2")
//                    }
//                case 1:
//                    self.numbers.insert(value, at: indexPath.row)
//                    if self.alpabets.contains(value) {
//                        self.alpabets = self.alpabets.filter { $0 != value}
//                        self.tableViewTwo.reloadData()
//                    } else {
//                        print("ELSE tag 1")
//                    }
//                default:
//                    break
//                }
//                indexPaths.append(indexPath)
//
//            }
//            tableView.insertRows(at: indexPaths, with: .automatic)
//        }
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
    

    
}
