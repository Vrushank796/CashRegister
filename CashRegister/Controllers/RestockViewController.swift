//
//  RestockViewController.swift
//  CashRegister
//
//  Created by Vrushank on 2022-02-25.
//

import UIKit

class RestockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var appProductCollection: ProductCollection?
    
    @IBOutlet weak var newQuantityText: UITextField!
    
    @IBOutlet weak var RestockProductTable: UITableView!
    
    //Set variable to check if user have selected any row from RestockProductTable
    var rowSelected : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appProductCollection = (UIApplication.shared.delegate as! AppDelegate).productCollection
    }
    
    //When restock button is pressed by user restockBtn action would be called
    @IBAction func restockBtn(_ sender: Any) {
        //If user have entered the new product quantity and table row is selected then update the product quantity
        if(newQuantityText.text != "" && rowSelected == 1){
            
            //Get the index of the selected product from the table
            let restockQtyObject : Product = (appProductCollection?.allProducts[RestockProductTable.indexPathForSelectedRow!.row])!
            
            let newQty = newQuantityText.text
            
            let exp: NSExpression = NSExpression(format: newQty!)
            let pNewQty: Int? = exp.expressionValue(with:nil, context: nil) as? Int
            
            restockQtyObject.quantity = restockQtyObject.quantity +  Int(pNewQty!)
            
            //Reset the required variables
            newQuantityText.text = ""
            rowSelected = 0
            
            //Reload the Restock Product Table after product is restocked and product quantity is updated successfully
            RestockProductTable.reloadData()
        }
        //If user have not selected the product from table or have not entered the quantity then it would give the alert message as follows
        else{
            
            let defaultAction = UIAlertAction(title: "OK",
                                              style: .default) { [self] (action) in
                //Reset user entered new quantity
                newQuantityText.text = ""
                
                //Change the selected background view of the cell.
                if(rowSelected == 1){
                    RestockProductTable.deselectRow(at: RestockProductTable.indexPathForSelectedRow!, animated: true)
                    
                    rowSelected = 0
                }
                else{
                    rowSelected = 0
                }
            }
            
            //AlertController would control the alert and it would give the alert message and would perform the alert actions defined in default action
            let alert:UIAlertController = UIAlertController(title: "Error", message: "You have to select an item and provide a new quantity", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    //If cancel button is pressed then it will redirect back to the manager panel using dismiss method
    @IBAction func cancelRestockBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Restock Product Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let productCount = appProductCollection?.allProducts
        return (productCount?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //dequeueResuableCell method is used to save memory usage
        let cell = tableView.dequeueReusableCell(withIdentifier: "productRestockCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel!.text = appProductCollection!.allProducts[indexPath.row].name
        
        cell.detailTextLabel!.text = "\(appProductCollection!.allProducts[indexPath.row].quantity)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //If product is selected from the Restock Table it would focus on text field to allow user to enter new product quantity to restock that product
        newQuantityText.becomeFirstResponder()
        
        //Set rowSelected variable if row is selected
        rowSelected = 1
    }
    
}
