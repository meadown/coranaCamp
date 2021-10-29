//
//  symptomsWebLinkTableViewCell.swift
//  AwareCorona
//
//  Created by Meadown on 17/5/20.
//  Copyright © 2020 Meadown. All rights reserved.
//

import UIKit

class symptomsWebLinkTableViewCell: UITableViewCell {

    @IBOutlet weak var SymptomsLinkholderView: UIView!
    @IBOutlet weak var lblSymptomsTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        SymptomsLinkholderView.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
