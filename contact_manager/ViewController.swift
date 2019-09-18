//
//  TableViewController.swift
//  contact_manager
//
//  Created by meagh054 on 9/3/19.
//  Copyright © 2019 solomon. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var contacts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.dataSource = self
        tableView.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            print("Printing what's in core data")
            
            var temp_contacts = [String]()
            var contact_tuples = [(lateness: Double, name: String)]()
            
            // Calculate lateness : current_timestamp - (contact timestamp) - (contact frequency in seconds)
            // Add to array of tuples : (lateness, name)
            // Sort contacts by lateness (Descending order)
            for data in result as! [NSManagedObject] {
                print(data)
                //print(data.value(forKey: "name") as! String)
                let contact_timestamp = data.value(forKey: "contact_timestamp") as! Double
                let current_timestamp = NSDate().timeIntervalSince1970
                let contact_frequency_string = data.value(forKey: "interaction") as! String
                var contact_frequency = Double(0)
                
                if(contact_frequency_string == "Daily"){
                    contact_frequency = 86400
                }
                else if (contact_frequency_string == "Weekly"){
                    contact_frequency = 604800
                }
                else if (contact_frequency_string == "Every Two Weeks"){
                    contact_frequency = 1209600
                }
                else if (contact_frequency_string == "Monthly") {
                    contact_frequency = 2419200
                }
                else if (contact_frequency_string == "Every Two Months"){
                    contact_frequency = 4838400
                }
                else {
                    print("Contact Frequency Not Found (Weird ass error)")
                }
                
                let lateness = current_timestamp - contact_timestamp - contact_frequency
                contact_tuples.append((lateness: lateness, name: data.value(forKey: "name") as! String))
                
                print("printing contact frequency of " + (data.value(forKey: "name") as! String))
                print(contact_frequency)
                
                //temp_contacts.append(data.value(forKey: "name") as! String)
            }
            contact_tuples.sort(by: >)
            print(contact_tuples)
            
            for tuple in contact_tuples {
                temp_contacts.append(tuple.1)
            }
            
            self.contacts = temp_contacts
            tableView.reloadData()
        } catch {
            print("Failed to load from core data")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        //print(contacts)
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            print("Printing what's in core data")
            
            var temp_contacts = [String]()
            var contact_tuples = [(lateness: Double, name: String)]()
            
            // Calculate lateness : current_timestamp - (contact timestamp) - (contact frequency in seconds)
            // Add to array of tuples : (lateness, name)
            // Sort contacts by lateness (Descending order)
            for data in result as! [NSManagedObject] {
                print(data)
                //print(data.value(forKey: "name") as! String)
                let contact_timestamp = data.value(forKey: "contact_timestamp") as! Double
                let current_timestamp = NSDate().timeIntervalSince1970
                let contact_frequency_string = data.value(forKey: "interaction") as! String
                var contact_frequency = Double(0)
                
                if(contact_frequency_string == "Daily"){
                    contact_frequency = 86400
                }
                else if (contact_frequency_string == "Weekly"){
                    contact_frequency = 604800
                }
                else if (contact_frequency_string == "Every Two Weeks"){
                    contact_frequency = 1209600
                }
                else if (contact_frequency_string == "Monthly") {
                    contact_frequency = 2419200
                }
                else if (contact_frequency_string == "Every Two Months"){
                    contact_frequency = 4838400
                }
                else {
                    print("Contact Frequency Not Found (Weird ass error)")
                }
                
                let lateness = current_timestamp - contact_timestamp - contact_frequency
                contact_tuples.append((lateness: lateness, name: data.value(forKey: "name") as! String))
                
                print("printing contact frequency of " + (data.value(forKey: "name") as! String))
                print(contact_frequency)
                
                //temp_contacts.append(data.value(forKey: "name") as! String)
            }
            contact_tuples.sort(by: >)
            print(contact_tuples)
            
            for tuple in contact_tuples {
                temp_contacts.append(tuple.1)
            }
            
            self.contacts = temp_contacts
            tableView.reloadData()
        } catch {
            print("Failed to load from core data")
        }
        
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactCell
            // style for table view cells
            cell.textLabel?.text = contacts[indexPath.row]
            cell.textLabel?.font = UIFont(name: "SFProText-Medium", size: 20.0)
            cell.textLabel?.font = cell.textLabel?.font.withSize(20)
        print("printing cells label in cellForRowAt")
        print(cell.textLabel?.text ?? "")
            return cell
    }
    
    
    
    
    // A Contact Cell has been selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactCell
        let name = contacts[indexPath.row]
        var relationship = ""
        var contentment = ""
        var interaction = ""
        print("printing what we know about this cell")
        
        // Fetch from Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let this_name = data.value(forKey: "name") as! String
                //print(data.value(forKey: "username") as! String)
                if (this_name == contacts[indexPath.row]){
                    print("This is the data we want")
                    relationship = data.value(forKey: "relationship") as! String
                    contentment = data.value(forKey: "contentment") as! String
                    interaction = data.value(forKey: "interaction") as! String
                }
            }
            
        } catch {
            
            print("Failed")
        }
        print("printing results of CoreData request")
        print(name)
        print(relationship)
        print(contentment)
        print(interaction)
        
        
        // Switches the view and passes the data of the selected cell to
        // the view where you can edit the contact (UpdateContactController)
        cell.view_switch = {
            [unowned self] in
            //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let second_vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateContactController") as! UpdateContactController
            //let second_vc = UpdateContactController(nibName: nil, bundle: nil) as! UpdateContactController
            print("printing what this View Controller is")
            print(second_vc.contentment_data)
            second_vc.selected_name = name
            second_vc.selected_contentment = contentment
            second_vc.selected_interaction = interaction
            second_vc.selected_relationship = relationship
            //print(second_vc)
            self.present(second_vc, animated: true, completion: nil)
            //navigationController?.pushViewController(secondVC, animated: true)
        }
        cell.elementTapped()
    }

    @IBAction func fill_contact(_ sender: Any) {
        performSegue(withIdentifier: "new_contact", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newContactController = segue.destination as? NewContactController
        newContactController!.contacts = contacts
    }
    
    //@IBAction func save(_ unwindSegue: UIStoryboardSegue) {
        //if let newContactController = unwindSegue.source as? NewContactController {
            //contacts = newContactController.contacts
            //print("this should be redundant now " + )
        //}
    //}
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
