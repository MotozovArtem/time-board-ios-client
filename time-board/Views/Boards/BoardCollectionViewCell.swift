//
//  StepCollectionViewCell.swift
//  time-board
//
//  Created by Tianid on 04.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import MobileCoreServices


class BoardCollectionViewCell: UICollectionViewCell {
    
    private var step: Board?
    var presenter: BoardCollectionViewCellPresenterProtocol? {
        didSet {
            setupBoardSettingButton()
        }
    }
    
    @IBOutlet weak var buttonsView: UIView!
    //    @IBOutlet weak var tableView: SelfSizedTableView!
    @IBOutlet weak var tableView: UITableView!
    //    @IBOutlet weak var tableView: SelfSizedTableView!
    
    //    @IBOutlet weak var tableView: UITableView!
    
    //    @IBOutlet weak var tableView: SelfSizedTableView!
    @IBAction func addButtonAction(_ sender: UIButton) {
        guard let data = self.step else { return }
        data.task.append("INSERTED TASK")
        let addedIndexPath = IndexPath(item: data.task.count - 1, section: 0)
        
        self.tableView.insertRows(at: [addedIndexPath], with: .automatic)
        self.tableView.scrollToRow(at: addedIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        refreshTableHeader()
    }
    
    private lazy var boardSettingsButton: UIButton? = {
        guard let presenter = presenter else { return nil }
        //MARK: Delete Test after all
        guard presenter.boardType == .CommonProject || presenter.boardType == .Test else { return nil }
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(boardSettingsButtonAction(_:)), for: .touchUpInside)
        button.setImage(UIImage(named: "icons8-menu-vertical-25"), for: .normal)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
        
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        
        tableView.register(UINib(nibName: "BoardContainerTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tableView.tableFooterView = UIView()
    }
    
    private func setupBoardSettingButton() {
        guard let button = boardSettingsButton else { return }
        button.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.addSubview(button)
        
        button.anchor(top: buttonsView.topAnchor,
                      leading: nil,
                      bottom: buttonsView.bottomAnchor,
                      trailing: buttonsView.trailingAnchor,
                      padding: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 8),
                      size: .zero,
                      centerX: nil,
                      centerY: nil,
                      centerXOffset: 0,
                      centerYOffset: 0)
        
    }
    
    @objc private func boardSettingsButtonAction(_ sender: UIButton) {
        presenter?.settingsBoardButtonTapped(cell: self)
    }
    
    func setup(_ step: Board) {
        self.step = step
        tableView.reloadData()
        tableView.backgroundColor = UIColor(displayP3Red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    //        tableView.backgroundColor = .red
    }
    
    private func getTableHeaderText() -> String? {
        guard let step = step else { return nil }
        return step.title + " " + String(step.task.count)
    }
    
    private func updateTableHeaderText(headerText: String) {
        tableView.headerView(forSection: 0)?.textLabel?.text = headerText
    }
    
    func refreshTableHeader() {
        guard let text = getTableHeaderText() else { return }
        updateTableHeaderText(headerText: text)
    }
    
    
}

//MARK: - table view DataSource and Delegate
extension BoardCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return step?.task.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? UITableViewHeaderFooterView else { return }
        view.contentView.backgroundColor = UIColor(displayP3Red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
        view.textLabel?.textColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UITableViewHeaderFooterView()
        view.textLabel?.adjustsFontSizeToFitWidth = true
        return view
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return getTableHeaderText()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BoardContainerTableViewCell
        //        cell.textLabel?.text = "\(step!.task[indexPath.row])"
        cell.boardDescriptionLabel?.text = "\(step!.task[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = DetailViewViewController()
        presenter?.taskCellTapped(detailViewController)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.backgroundView?.backgroundColor = .clear
    }
}

//MARK: - table view Drag Delegate
extension BoardCollectionViewCell: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let steap = step, let stringData = steap.task[indexPath.row].data(using: .utf8) else {
            return []
        }
        
        let itemProvider = NSItemProvider(item: stringData as NSData, typeIdentifier: kUTTypePlainText as String)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        session.localContext = (step, indexPath, tableView, self)
        
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        guard let cell = tableView.cellForRow(at: indexPath) as? BoardContainerTableViewCell else { return nil }
        let previewParameters = UIDragPreviewParameters()
        previewParameters.backgroundColor = UIColor.clear // transparent background
        previewParameters.visiblePath = UIBezierPath(roundedRect: cell.contentView.bounds, cornerRadius: 10)
        return previewParameters
    }
}

//MARK: - table view Drop Delegate
extension BoardCollectionViewCell: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        if coordinator.session.hasItemsConforming(toTypeIdentifiers: [kUTTypePlainText as String]) {
            coordinator.session.loadObjects(ofClass: NSString.self) { (items) in
                guard let string = items.first as? String else {
                    return
                }
                
                switch (coordinator.items.first?.sourceIndexPath, coordinator.destinationIndexPath) {
                case (.some(let sourceIndexPath), .some(let destinationIndexPath)):
                    // Same Table View
                    let updatedIndexPaths: [IndexPath]
                    if sourceIndexPath.row < destinationIndexPath.row {
                        updatedIndexPaths =  (sourceIndexPath.row...destinationIndexPath.row).map { IndexPath(row: $0, section: 0) }
                    } else if sourceIndexPath.row > destinationIndexPath.row {
                        updatedIndexPaths =  (destinationIndexPath.row...sourceIndexPath.row).map { IndexPath(row: $0, section: 0) }
                    } else {
                        updatedIndexPaths = []
                    }
                    self.tableView.beginUpdates()
                    self.step?.task.remove(at: sourceIndexPath.row)
                    self.step?.task.insert(string, at: destinationIndexPath.row)
                    self.tableView.reloadRows(at: updatedIndexPaths, with: .automatic)
                    self.tableView.endUpdates()
                    break
                    
                case (nil, .some(let destinationIndexPath)):
                    // Move data from a table to another table
                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                    self.tableView.beginUpdates()
                    self.step?.task.insert(string, at: destinationIndexPath.row)
                    self.tableView.insertRows(at: [destinationIndexPath], with: .automatic)
                    self.refreshTableHeader()
                    self.tableView.endUpdates()
                    break
                    
                    
                case (nil, nil):
                    // Insert data from a table to another table when table is empty
                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                    self.tableView.beginUpdates()
                    self.step?.task.append(string)
                    self.tableView.insertRows(at: [IndexPath(row: self.step!.task.count - 1 , section: 0)], with: .automatic)
                    self.refreshTableHeader()
                    self.tableView.endUpdates()
                    break
                    
                default: break
                    
                }
            }
        }
    }
    
    func removeSourceTableData(localContext: Any?) {
        if let (dataSource, sourceIndexPath, tableView, sourceCell) = localContext as? (Board, IndexPath, UITableView, BoardCollectionViewCell) {
            tableView.beginUpdates()
            dataSource.task.remove(at: sourceIndexPath.row)
            if dataSource === sourceCell.step {
                tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
                sourceCell.refreshTableHeader()
            }
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        //        if let (dataSource, sourceIndexPath, _, numberOfRows) = session.localDragSession?.localContext as? (Step, IndexPath, UITableView, Int) {
        //            session.localDragSession?.localContext = (dataSource,sourceIndexPath, tableView, numberOfRows)
        //            print(sourceIndexPath, numberOfRows, destinationIndexPath, Date())
        //
        //        }
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
}
