//
//  HistoryCollection.swift
//  CashRegister
//
//  Created by Vrushank on 2022-02-24.
//

import Foundation

class HistoryCollection{
    
    //Define the purchaseHistory array to store the product purchase history throughout the app lifecycle
    var purchaseHistory : [History] = [History]()
    
    //Add product purchase history to the purchaseHistory array
    func addPurchaseHistory(n:String,q:Int,tPrice:Float,pDt:String)
    {
        purchaseHistory.append(History(pName: n, qty: q, totPrice: tPrice, pDate: pDt))
    }
}
