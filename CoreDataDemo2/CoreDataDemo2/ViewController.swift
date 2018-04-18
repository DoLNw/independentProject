//
//  ViewController.swift
//  CoreDataDemo2
//
//  Created by 王嘉诚 on 2018/3/28.
//  Copyright © 2018年 DoLNw. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UITableViewController ,NSFetchedResultsControllerDelegate{
    
    var players: [Mood] = []
    var frc: NSFetchedResultsController<Mood>!
    var likeOrDislike: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataUsingfrc()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        fetchData()
//        tableView.reloadData()
//
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - tableview
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "player", for: indexPath) as! PlayerTableViewCell
        
        cell.nameLabel.text = players[indexPath.row].name
        cell.numberLabel.text = "\(players[indexPath.row].number)"
        cell.picture.image = UIImage(data: players[indexPath.row].image!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
//            self.players.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(self.frc.object(at: indexPath))
            appDelegate.saveContext()
            
            completion(true)
        }
        
        return  UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let orangeAction = UIContextualAction(style: .normal, title: "\(likeOrDislike ? "Dislike" : "Like")") { (_, _, completion) in
            self.likeOrDislike = !self.likeOrDislike
            
            completion(true)
        }
        orangeAction.backgroundColor = UIColor.orange
        orangeAction.image = UIImage(named: "\(likeOrDislike ? "unfav" : "fav")")
        
        return UISwipeActionsConfiguration(actions: [orangeAction])
    }
    
    //MARK: - coredata
    
    func insertData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let player = Mood(context: appDelegate.persistentContainer.viewContext)
        player.name = "DoLNw"
        player.number = 1
        players.append(player)
        tableView.reloadData()
        
        appDelegate.saveContext()
    }
    
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func fetchDataUsingfrc() {
        let description = NSSortDescriptor(key: "number", ascending: true)
        let request:NSFetchRequest<Mood> = Mood.fetchRequest()
        request.sortDescriptors = [description]
        frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        do {
            try frc.performFetch()
            if let objects = frc.fetchedObjects {
                players = objects
            }
        } catch {
            print(error)
        }
    }
    
//    //获取所有数据的方法
//    func fetchData() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        do {
//            players = try appDelegate.persistentContainer.viewContext.fetch(Mood.fetchRequest())
//        } catch {
//            print(Error.self)
//        }
//    }
    
    //MARK: - frc
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            tableView.reloadData()
        }
        
        if let objects = frc.fetchedObjects {
            players = objects
        }
        
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    //MARK: - navigation
    @IBAction func backToHome(segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let row = tableView.indexPathForSelectedRow!.row
            let destination = segue.destination as! DetailViewController
            
            let player = players[row]
            destination.imageData = player.image
            destination.titleName = player.name!
        }
    }
}

