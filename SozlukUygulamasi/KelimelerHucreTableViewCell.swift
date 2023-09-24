//
//  KelimelerHucreTableViewCell.swift
//  SozlukUygulamasi
//
//  Created by Tülay MAYUNCUR on 24.09.2023.
//

import UIKit

class KelimelerHucreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ingilizceLabel: UILabel!
    
    @IBOutlet weak var turkceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
