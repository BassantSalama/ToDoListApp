//
//  TodoCell.swift
//  FIRST PROJECT (TODO LIST)
//
//  Created by mac on 26/09/2024.
//

import UIKit

class TodoCell: UITableViewCell {
    
    
    @IBOutlet weak var todoImageView: UIImageView!
    
    @IBOutlet weak var todoTitleLabel: UILabel!
    
    @IBOutlet weak var todoCreationDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
