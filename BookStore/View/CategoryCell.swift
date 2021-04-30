//
//  CategoryCell.swift
//  BookStore
//
//  Created by Sanjay Mali on 29/04/21.
//

import UIKit

class CategoryCell: UITableViewCell {
    @IBOutlet weak var bgView:UIView!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var trailling_Icon:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
