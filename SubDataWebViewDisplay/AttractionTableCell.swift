//
//  AttractionTableCell.swift
//  SubDataWebViewDisplay
//
//  Created by Sinchon on 2021/04/27.
//

import UIKit

class AttractionTableCell: UITableViewCell {

    @IBOutlet weak var attractionImage: UIImageView!
    @IBOutlet weak var attractionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
