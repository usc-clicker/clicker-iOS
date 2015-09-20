//
//  MultipleChoiceTableViewCell.swift
//  clicker
//
//  Created by Wayne Chi on 9/17/15.
//  Copyright (c) 2015 Univeristy of Southern California. All rights reserved.
//

import UIKit

class MultipleChoiceTableViewCell: UITableViewCell {

    @IBOutlet var Answer: UILabel!
    @IBOutlet var Number: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
