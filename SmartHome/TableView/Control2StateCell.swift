//
//  Control2StateCell.swift
//  SmartHome
//
//  Created by Alpha on 3/3/20.
//  Copyright © 2020 Alpha. All rights reserved.
//

import UIKit

class Control2StateCell: UITableViewCell {
    @IBOutlet weak var lblDevice: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var btnChange: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        btnChange.backgroundColor = .clear
        btnChange.layer.cornerRadius = 5
        btnChange.layer.borderWidth = 1
        btnChange.layer.borderColor = UIColor.black.cgColor

      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
