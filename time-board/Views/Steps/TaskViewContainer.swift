//
//  TaskViewContainer.swift
//  time-board
//
//  Created by Tianid on 01.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class TaskViewContainer: UIView {
    
    private let cellIdentifier: String = "CellIdentifier"
    //MARK: - TEST
    var contr = [Int]()
    //MARK: -
    @IBOutlet weak var stepNameLabel: UILabel!
    @IBOutlet weak var taskCountLabel: UILabel!
    @IBOutlet weak var taskTableView: SelfSizedTableView!
    
    @IBOutlet weak var createTaskButton: UIButton!
    @IBOutlet weak var deleteTaskButton: UIButton!
    @IBAction func createTaskButtonAction(_ sender: UIButton) {
        createTaskButton.backgroundColor = .red
        contr.append(1)
        let indexPath = IndexPath(row: contr.count - 1, section: 0)
//        taskTableView.beginUpdates()

        taskTableView.insertRows(at: [indexPath], with: .right)
//        taskTableView.endUpdates()
        taskTableView.scrollToRow(at: IndexPath(row: contr.count - 1, section:0), at: .none, animated: true)

    }
    
    @IBAction func deleteTaskButtonAction(_ sender: UIButton) {
        let _ = contr.popLast()
        let indexPath = IndexPath(row: contr.count, section: 0)
        taskTableView.beginUpdates()
        taskTableView.deleteRows(at: [indexPath] , with: .fade)
        taskTableView.endUpdates()
        taskTableView.setContentOffset(taskTableView.contentOffset, animated: false)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        taskTableView.register(UINib(nibName: "TaskContainerTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
        taskTableView.separatorStyle = .none
    }
}

extension TaskViewContainer: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? TaskContainerTableViewCell
        guard let tableCell = cell else { return  UITableViewCell() }
        tableCell.selectionStyle = .none
        //MARK: - TEST
        if indexPath.row.isMultiple(of: 2) {
            tableCell.taskDescriptionLabel.text = "(\(indexPath.row)) LOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONG TEXT"

        } else {
            tableCell.taskDescriptionLabel.text = "(\(indexPath.row)) SHORT TEXT"
        }
        //MARK: -
        return tableCell
    }
}
