//
//  HistoryDetailViewController.swift
//  CashRegister
//
//  Created by Vrushank on 2022-02-24.
//

import UIKit

class HistoryDetailViewController: UIViewController {
    
    var appHistoryCollection: HistoryCollection?
    
    //Define variable to get the product history array object from historyTable and display detailed product history here
    var pHistoryFromHistoryTVC:History?
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var purchaseDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appHistoryCollection = (UIApplication.shared.delegate as! AppDelegate).historyCollection
        
        //Set product history properties label
        productNameLabel.text = pHistoryFromHistoryTVC?.name
        quantityLabel.text = "\(pHistoryFromHistoryTVC!.quantity)"
        totalPriceLabel.text = "Total Amount: $\(pHistoryFromHistoryTVC!.totalPrice)"
        purchaseDateLabel.text = pHistoryFromHistoryTVC?.purchaseDate
        
    }
}
