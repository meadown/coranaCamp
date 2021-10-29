//
//  AdviceTableViewCell.swift
//  AwareCorona
//
//  Created by Meadown on 12/5/20.
//  Copyright © 2020 Meadown. All rights reserved.
//

import UIKit

class AdviceTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAdviceLink: UILabel!
    @IBOutlet weak var LinkHolderView: UIView!
  /*  {
        didSet
        {
            let tapgesture = UIGestureRecognizer(target: self, action: #selector(LinkHolderViewtTaped))
            LinkHolderView.addGestureRecognizer(tapgesture)
            LinkHolderView.isUserInteractionEnabled = true
        }
    }
    
    @objc func LinkHolderViewtTaped()
       {
        LinkHolderView.layer.backgroundColor = UIColor.systemTeal.cgColor
       }
       */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        LinkHolderView.layer.cornerRadius = 10
        // Initialization code
    }

   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
