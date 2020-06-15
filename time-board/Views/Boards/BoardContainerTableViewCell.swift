//
//  TaskContainerTableViewCell.swift
//  time-board
//
//  Created by Tianid on 02.06.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class BoardContainerTableViewCell: UITableViewCell {

    @IBOutlet weak var boardDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
