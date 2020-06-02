//
//  TaskContainerTableViewCell.swift
//  time-board
//
//  Created by Tianid on 02.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class TaskContainerTableViewCell: UITableViewCell {

    @IBOutlet weak var taskDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
