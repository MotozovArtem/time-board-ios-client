//
//  TaskDataSource.swift
//  time-board
//
//  Created by Tianid on 03.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import MobileCoreServices

class TaskDataSource: NSObject, UITableViewDataSource {

    private let cellID = "CellID"
    var models: [Int]
    
    init(models: [Int]) {
        self.models = models
        super.init()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TaskContainerTableViewCell
        let model = models[indexPath.row]
        
        cell.taskDescriptionLabel.text = String(model)
        return cell
    }
    
    func moveItem(at sourceindex: Int, to destinationIndex: Int) {
        guard sourceindex != destinationIndex else { return }
        let model = models[sourceindex]
        models.remove(at: sourceindex)
        models.insert(model, at: destinationIndex)
    }
    
    func addModel(_ newModel: Int, at index: Int) {
        models.insert(newModel, at: index)
    }
    
    func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
        let model = models[indexPath.row]
        let itemProvider = NSItemProvider()
        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { complition in
            let data = String(model).data(using: .utf8)
            complition(data, nil)
            return nil
        }
        
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = model
        return [dragItem]
    }
    
}
