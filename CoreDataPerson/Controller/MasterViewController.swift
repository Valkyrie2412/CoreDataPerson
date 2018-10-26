//
//  MasterViewController.swift
//  CoreDataPerson
//
//  Created by Hiếu Nguyễn on 9/25/18.
//  Copyright © 2018 Hiếu Nguyễn. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//    var persons = [Person]()
//    var filteredPerson = [Person]()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataService.sharedInstance.mocEntity.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        cell.labelName.text = DataService.sharedInstance.mocEntity[indexPath.row].name
        cell.labelAge?.text = String(DataService.sharedInstance.mocEntity[indexPath.row].age)
        cell.pictureView.image = DataService.sharedInstance.mocEntity[indexPath.row].photo as? UIImage
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailViewController {
            if let selectedPerson = tableView.indexPathForSelectedRow {
//                if let index = persons.index(of: filteredPerson[selectedPerson.row]) {
//                    detailViewController.person = filteredPerson[index]
//                }
                detailViewController.indexPath = selectedPerson
                detailViewController.person = DataService.sharedInstance.mocEntity[selectedPerson.row]
            }
        }
    }

    
    
//    @IBAction func unwindToPersonList(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.source as? DetailViewController, let person = sourceViewController.person {
//
//            if let selectedIndexPath = tableView.indexPathForSelectedRow {
//                if let index = persons.index(of: filteredPerson[selectedIndexPath.row]) {
//                    persons[index] = person
//                    filteredPerson = persons
//                }
//            }
//            else {
//                // Add a new person
//
//
//                persons.append(person)
//                filteredPerson = persons
//            }
//            tableView.reloadData()
//            // Save coredata
//            DataService.sharedInstance.saveData()
//        }
//    }
    
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            DataService.sharedInstance.remove(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
