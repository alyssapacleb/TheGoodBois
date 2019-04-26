//
//  SavedPetsTableViewCell.swift
//  TheGoodBois
//
//  Created by Argandona Vite, Angel R on 4/25/19.
//  Copyright © 2019 The Good Bois. All rights reserved.
//

import UIKit

class SavedPetsTableViewCell: UITableViewCell {

    @IBOutlet weak var SavedPetsTableImage: UIImageView!
    @IBOutlet weak var SavedPetsTableLabel1: UILabel!
    
    func displayContent(image: UIImage, label1: String){
        SavedPetsTableImage.image = image
        SavedPetsTableLabel1.text = label1
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
