//
//  ProductCollection.swift
//  CashRegister
//
//  Created by Vrushank on 2022-02-22.
//

import Foundation

class ProductCollection{
    
    //Define and initialize the allProducts array to store the product information 
    var allProducts : [Product] = [Product(pName: "Jackets",qty: 50,unitPrice: 80),Product(pName: "Pants",qty: 20,unitPrice: 30),Product(pName: "Shoes",qty: 50,unitPrice: 79.90),Product(pName: "Hats",qty: 10,unitPrice: 20.5),Product(pName: "Tshirts",qty: 10,unitPrice: 25),Product(pName: "Dresses",qty: 24,unitPrice: 95.50)];
    
    //Calculate Total Price of the product
    func calculateTotalPrice(n:String,q:Int) -> Float{
        var totalPrice : Float = 0.0
        if let index = allProducts.firstIndex(where:{$0.name == n}){
            if(allProducts[index].quantity != 0){
                totalPrice = Float(q) * allProducts[index].price
            }
        }
        return totalPrice;
    }
    
    //Check Product Quantity
    func checkQuantity(n:String) -> Int{
        var qty : Int = 0
        if let index = allProducts.firstIndex(where:{$0.name == n}){
            qty = allProducts[index].quantity
        }
        return qty;
    }
    
    //Buy Product by checking quantity 
    func buyProduct(n:String,q:Int)->Bool{
        var bought : Bool = false
        
        //Fetch the index for the selected product to buy and perform product quantity updation after require validation
        if let index = allProducts.firstIndex(where:{$0.name == n}){
            if(checkQuantity(n: n) == 0){
                //If product out of stock return false
                bought = false
            }
            else if(checkQuantity(n:n) >= q){
                //If product is in quantity then proceed and return true and update the product quantity based on user entered quantity as follows
                let oldQty = allProducts[index].quantity
                let newQty = oldQty - q
                allProducts[index].quantity = newQty
                
                bought = true
            }
            else{
                bought = false
            }
        }
        return bought
    }
}

