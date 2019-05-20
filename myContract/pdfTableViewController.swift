//
//  pdfTableViewController.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/20.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit
import LeanCloud
import PDFKit

class pdfTableViewController: UITableViewController {
    
    var contracts :[LCObject]?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contracts = DataHandle.shareInstence.getObjects()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if (contracts != nil){
            print(contracts!.count)
            return contracts!.count
        }else{
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath)
        var string = contracts?[indexPath.row].get("name")!.jsonString
        string?.removeFirst()
        string?.removeLast()
        cell.textLabel?.text = string
        return cell
    }
    
    //转场准备
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var urlstring :String?
        if let viewcontroller = segue.destination as? pdfViewController ,
            let indexpath = tableView.indexPathForSelectedRow{
            //            viewcontroller.urlstring = (contracts?[indexpath.row].get("url")!.jsonString) ?? ""
            urlstring = contracts?[indexpath.row].get("url")!.jsonString ?? ""
            if let string = urlstring{
                print(string)
                let realUrlString = string.trimmingCharacters(in: .punctuationCharacters)
                print(realUrlString)
                let url = URL(string: realUrlString)
                viewcontroller.document = PDFDocument(url: url!)
            }else{
                print("no string")
            }
        }
    }
    
    
    
}

