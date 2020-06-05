//
//  StepCollectionViewCell.swift
//  time-board
//
//  Created by Tianid on 04.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class StepCollectionViewCell: UICollectionViewCell {
    
    
//    @IBOutlet weak var tableView: SelfSizedTableView!
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var tableView: SelfSizedTableView!
    
//    @IBOutlet weak var tableView: UITableView!
    
//    @IBOutlet weak var tableView: SelfSizedTableView!
    @IBAction func addButtonAction(_ sender: UIButton) {
        //MARK: ADD NEW TASK
    }
    
    
    
    
    private var step: Step?
    var parentVC: StepCollectionViewController?
    
    func setup(_ step: Step) {
        self.step = step
        tableView.reloadData()
        tableView.backgroundColor = .red
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
        
        tableView.register(UINib(nibName: "TaskContainerTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tableView.tableFooterView = UIView()
    }
    
    
}

extension StepCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return step?.task.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return step?.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TaskContainerTableViewCell
//        cell.textLabel?.text = "\(step!.task[indexPath.row])"
        cell.taskDescriptionLabel?.text = "\(step!.task[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
