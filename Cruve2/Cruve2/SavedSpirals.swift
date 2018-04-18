//
//  SavedSpirals.swift
//  Cruve2
//
//  Created by 王嘉诚 on 2018/4/7.
//  Copyright © 2018年 DoLNw. All rights reserved.
//

import UIKit

class SavedSpirals: UITableViewController {
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    var spirals = [spiralStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        if let saved = defaults.object(forKey: "spirals") as? Data{
            let jsonDecoder = JSONDecoder()
            do{
                spirals = try jsonDecoder.decode([spiralStruct].self, from: saved)
            } catch {
                print("Failed to load spirals")
            }
        }
//        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return spirals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spiral", for: indexPath) as! SpiralCell
        cell.configurationLabel.text = "r1: \(spirals[indexPath.row].r1)  r2: \(spirals[indexPath.row].r2)  k : \(spirals[indexPath.row].k)  speed:  \(spirals[indexPath.row].speed) \nhue: \(spirals[indexPath.row].hue)  sat: \(spirals[indexPath.row].sat)  bri: \(spirals[indexPath.row].bri)  alpha:  \(spirals[indexPath.row].alpha)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
            self.spirals.remove(at: indexPath.row)
            let jsonEncoder = JSONEncoder()
            if let saved = try? jsonEncoder.encode(self.spirals) {
                let defaults = UserDefaults.standard
                defaults.set(saved, forKey: "spirals")
            }
            completion(true)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPicture" {
            let destination = segue.destination as! PictureSpirals
            let row = tableView.indexPathForSelectedRow!.row
            destination.index = row
        }
    }


}
