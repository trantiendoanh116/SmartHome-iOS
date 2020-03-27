//
//  Control3StateCell.swift
//  SmartHome
//
//  Created by Alpha on 3/3/20.
//  Copyright © 2020 Alpha. All rights reserved.
//

import UIKit

class Control3StateCell: UITableViewCell {
    @IBOutlet weak var lblDevice: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var btnOff: UIButton!
    @IBOutlet weak var btnOn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnOff.backgroundColor = .clear
        btnOff.layer.cornerRadius = 5
        btnOff.layer.borderWidth = 1
        btnOff.layer.borderColor = UIColor.black.cgColor
        btnOn.backgroundColor = .clear
        btnOn.layer.cornerRadius = 5
        btnOn.layer.borderWidth = 1
        btnOn.layer.borderColor = UIColor.black.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
