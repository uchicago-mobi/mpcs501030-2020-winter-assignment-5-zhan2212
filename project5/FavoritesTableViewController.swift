//
//  FavoritesTableViewController.swift
//  project5
//
//  Created by Yueyang Zhang on 2/11/20.
//  Copyright © 2020 Yueyang Zhang. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    @IBOutlet weak var dismissButton: UIButton!
    // set up delegate
    weak var delegate: PlacesFavoritesDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        // load data
        DataManager.sharedInstance.loadAnnotationFromPlist()
    }
    
    @objc func buttonTapped(_ button: UIButton){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataManager.sharedInstance.favArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favPlace", for: indexPath)
        cell.textLabel?.text = DataManager.sharedInstance.favArr[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // dismiss the view
        dismiss(animated: true, completion: nil)
        // pass data to main view controller
        self.delegate?.favoritePlace(name: DataManager.sharedInstance.favArr[indexPath.row].name!)
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
