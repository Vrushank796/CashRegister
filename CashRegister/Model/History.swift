//
//  History.swift
//  CashRegister
//
//  Created by Vrushank on 2022-02-24.
//

import Foundation

class History{
    
    //Define and Initialize the Product Purchase History Properties such as name, quantity, total price and purchase date
    var name : String = ""
    var quantity : Int = 0
    var totalPrice : Float = 0.0
    var purchaseDate : String
    
    
    init (pName: String, qty:Int, totPrice: Float, pDate: String){
        name = pName
        quantity = qty
        totalPrice = totPrice
        purchaseDate = pDate
    }
}
