//
//  TaskViewContainer.swift
//  time-board
//
//  Created by Tianid on 01.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class TaskViewContainer: UIView {
    
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    var contr = [Int]()

    @IBOutlet weak var stepNameLabel: UILabel!
    @IBOutlet weak var taskCountLabel: UILabel!
    @IBOutlet weak var taskTableView: SelfSizedTableView!
    
    @IBOutlet weak var createTaskButton: UIButton!
    @IBAction func createTaskButtonAction(_ sender: UIButton) {
        createTaskButton.backgroundColor = .red
        contr.append(1)
        taskTableView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension TaskViewContainer: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
}
