//
//  HistoryTableViewController.swift
//  CashRegister
//
//  Created by Vrushank on 2022-02-24.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    
    @IBOutlet var historyTable: UITableView!
    
    var appHistoryCollection: HistoryCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appHistoryCollection = (UIApplication.shared.delegate as! AppDelegate).historyCollection
    }
    
    // MARK: - History Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let historyCount = appHistoryCollection?.purchaseHistory
        return (historyCount?.count)!
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //dequeueResuableCell method is used to save memory usage
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseHistoryCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel!.text = appHistoryCollection!.purchaseHistory[indexPath.row].name
        
        cell.detailTextLabel!.text = "\(appHistoryCollection!.purchaseHistory[indexPath.row].quantity)"
        
        return cell
    }
    
    //Prepare method to prepare the HistoryDetailView scene before it is presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Send the user selected productHistory array object based on the user productHistory cell selection from historyTable
        if segue.identifier == "toDetailHistory"{
            let destination = segue.destination as! HistoryDetailViewController
            
            destination.pHistoryFromHistoryTVC = (appHistoryCollection?.purchaseHistory[historyTable.indexPathForSelectedRow!.row])!
            
        }
    }
}
