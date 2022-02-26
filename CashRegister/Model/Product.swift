//
//  Product.swift
//  CashRegister
//
//  Created by Vrushank on 2022-02-22.
//

import Foundation

class Product{
    
    //Define and Initialize the Product Properties such as name, quantity and unit price
    var name : String = ""
    var quantity : Int = 0
    var price : Float = 0.0
    
    init (pName: String, qty:Int, unitPrice: Float){
        name = pName
        quantity = qty
        price = unitPrice
    }
}
