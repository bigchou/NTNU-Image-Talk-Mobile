//
//  ImageTableViewCell.swift
//  NTNU Image Talk Mobile
//
//  Created by WAN SHR-TZE on 24/12/2016.
//  Copyright © 2016 WAN SHR-TZE. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var imageDescription: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
