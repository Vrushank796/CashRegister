//
//  ProductTableViewCell.swift
//  CashRegister
//
//  Created by Vrushank on 2022-02-23.
//

import UIKit

//Custom Product Table View Cell displays product name, product quantity and product price
class ProductTableViewCell: UITableViewCell {
    
    //IBOutlets Connection for the required UILabels
    @IBOutlet weak var productName:UILabel!
    @IBOutlet weak var productQuantity:UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    //Default methods for custom TableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

