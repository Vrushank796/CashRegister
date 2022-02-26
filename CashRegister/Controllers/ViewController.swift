//
//  ViewController.swift
//  CashRegister
//
//  Created by Vrushank on 2022-02-22.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //Define variables to use model data of ProductCollection and HistoryCollection
    var appProductCollection: ProductCollection?
    var appHistoryCollection: HistoryCollection?
    
    //IBOutlets Connection for the required UILabels
    @IBOutlet var productLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    //IBOutlets Connection for the required productTable UITableView
    @IBOutlet weak var productTable: UITableView!
    
    //Define qty variable to manage the user inputted quantity
    var qty : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize variables to use model data
        appProductCollection = (UIApplication.shared.delegate as! AppDelegate).productCollection
        
        appHistoryCollection = (UIApplication.shared.delegate as! AppDelegate).historyCollection
        
        //Set Navigation Bar Title
        self.title = "Cash Register App"
    }
    
    //viewWillAppear method to reload data in productTable before main app scene is displayed after updating the product stock through manager panel
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productTable.reloadData()
    }
    
    //digitBtn action would be called when any digit buttons would pressed by user
    @IBAction func digitBtn(_ sender: Any) {
        if sender is UIButton{
            if let digit = (sender as! UIButton).titleLabel?.text{
                qty =  qty + digit
                quantityLabel.text = qty
                let productName = productLabel.text
                
                let quantity = Int(quantityLabel.text!)
                
                //Based on user entered product quantity total price would be updated by calling calculateTotalPrice method from Product Collection
                let price =  appProductCollection!.calculateTotalPrice(n: productName!, q: quantity!)
                
                totalPriceLabel.text = String(format: "%.2f", price)
            }
        }
    }
    
    //buyProduct action would be called when buy button would be pressed by the user
    @IBAction func buyProduct(_ sender: Any) {
        
        //Fetch the product name and quantity
        let productName = productLabel.text!
        
        let quantity = Int(quantityLabel.text!)
        
        //Check if product is selected or product name and quantity is set, if it's alright then
        if (productName != "Type" && quantityLabel.text != "Quantity"){
            
            //Get product properties such as name, quantity, total price and current date and time of purchase
            let chkQty = Int(appProductCollection!.checkQuantity(n: productName))
            
            let price =  appProductCollection!.calculateTotalPrice(n: productName, q: quantity!)
            
            let totalPrice = String(format: "%.2f", price)
            
            //If product is in quantity and all is set then it would return true otherwise false
            let boughtProduct = appProductCollection!.buyProduct(n: productName, q: quantity!)
            
            //Get the current date and time
            
            // Create Date
            let date = Date()
            
            // Create Date Formatter
            let dateFormatter = DateFormatter()
            
            // Set Date Format
            dateFormatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
            
            // Convert Date to String
            let currentDateTime = dateFormatter.string(from: date)
            
            //If product is in quantity and all is set then
            if (boughtProduct == true)
            {
                //MARK: - Save Purchase History
                
                appHistoryCollection?.addPurchaseHistory(n:productName,q:quantity!,tPrice:Float(totalPrice)!,pDt:currentDateTime)
                
                let buyMsg = "Successfully bought \(quantity!) \(productName) for $\(totalPrice)"
                
                //AlertController would control the alert and it would give the alert message and would perform the alert actions defined in successAction
                let successAlert:UIAlertController = UIAlertController(title: "Success", message: buyMsg, preferredStyle: UIAlertController.Style.alert)
                
                let successAction = UIAlertAction(title: "OK",
                                                  style: .default) { [self] (action) in
                    //Reset user entered quantity and other UI properties
                    productLabel.text = "Type"
                    quantityLabel.text = "Quantity"
                    totalPriceLabel.text = "Price"
                    qty = ""
                    productTable.reloadData()
                }
                
                successAlert.addAction(successAction)
                present(successAlert, animated: true, completion: nil)
            }
            //If user have entered more product quantity than it is in stock then it would give alert message as follows
            else if(boughtProduct == false && chkQty != 0){
                let overQtyAction = UIAlertAction(title: "OK",style: .default) { [self] (action) in
                    //Reset user entered quantity and more UI props
                    
                    productLabel.text = "Type"
                    quantityLabel.text = "Quantity"
                    totalPriceLabel.text = "Price"
                    qty = ""
                    productTable.reloadData()
                }
                
                //AlertController would control the alert and it would give the alert message and would perform the alert actions defined in overQtyAction
                let overQtyAlert:UIAlertController = UIAlertController(title: "Error", message: "Please select product, check it's stock and enter quantity again!", preferredStyle: UIAlertController.Style.alert)
                
                overQtyAlert.addAction(overQtyAction)
                present(overQtyAlert, animated: true, completion: nil)
            }
            //If product is out of stock then it would give alert message and user would not able to buy the product
            else{
                //AlertController would control the alert and it would give the alert message and would perform the alert actions defined in failureAction
                let failureAlert:UIAlertController = UIAlertController(title: "Error", message: "We are out of stock! Please try again", preferredStyle: UIAlertController.Style.alert)
                
                let failureAction = UIAlertAction(title: "OK",
                                                  style: .default) { [self] (action) in
                    //Reset user entered quantity and other UI properties
                    productLabel.text = "Type"
                    quantityLabel.text = "Quantity"
                    totalPriceLabel.text = "Price"
                    qty = ""
                    productTable.reloadData()
                }
                
                failureAlert.addAction(failureAction)
                present(failureAlert, animated: true, completion: nil)
            }
        }
        // If product is not selected or product name and quantity is not properly set it would give alert message
        else{
            let errorAction = UIAlertAction(title: "OK",
                                            style: .default) { [self] (action) in
                //Reset user entered quantity and other UI properties
                qty = ""
                productLabel.text = "Type"
                quantityLabel.text = "Quantity"
                totalPriceLabel.text = "Price"
                productTable.reloadData()
            }
            
            //AlertController would control the alert and it would give the alert message and would perform the alert actions defined in errorAction
            let errorAlert:UIAlertController = UIAlertController(title: "Error", message: "Please choose product and enter quantity!", preferredStyle: UIAlertController.Style.alert)
            
            errorAlert.addAction(errorAction)
            present(errorAlert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Product Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let productCount = appProductCollection?.allProducts
        return (productCount?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //dequeueResuableCell method is used to save memory usage
        let cell = tableView.dequeueReusableCell(withIdentifier: "productInfoCell", for: indexPath) as! ProductTableViewCell
        
        // Configure the cell...
        cell.productName.text = appProductCollection!.allProducts[indexPath.row].name
        
        cell.productQuantity.text = "\(appProductCollection!.allProducts[indexPath.row].quantity)"
        
        cell.productPrice.text = "\(appProductCollection!.allProducts[indexPath.row].price)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if let name = appProductCollection?.allProducts[indexPath.row].name{
            if let quantity = appProductCollection?.allProducts[indexPath.row].quantity{
                productLabel.text = "\(name)"
                quantityLabel.text = "\(quantity)"
                
                let price =  appProductCollection!.calculateTotalPrice(n: name, q: quantity)
                
                totalPriceLabel.text = String(format: "%.2f", price)
            }
        }
    }
}

