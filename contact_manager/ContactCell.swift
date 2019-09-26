//
//  ContactCell.swift
//  contact_manager
//
//  Created by meagh054 on 9/12/19.
//  Copyright © 2019 solomon. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    var view_switch = { }
    
    @IBOutlet weak var clock: UIImageView!
    
    func elementTapped() {
        view_switch()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
