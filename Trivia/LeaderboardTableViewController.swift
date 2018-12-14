//
//  LeaderboardTableViewController.swift
//  Trivia
//
//  Created by Sander de Vries on 14/12/2018.
//  Copyright © 2018 Sander de Vries. All rights reserved.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {
    
    var scores = [ServerResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        navigationItem.title = "Loading"
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        ResultController.shared.fetchScores { (scores) in
            if let scores = scores {
                DispatchQueue.main.async {
                    self.scores = scores
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.navigationItem.title = "Leaderboard"
                    self.tableView.reloadData()
                }
            }
        }
        
    }
  

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scores.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        
        let index = indexPath.row
        
        cell.textLabel?.text = scores[index].time
        cell.detailTextLabel?.text = "\(scores[index].correct)/\(scores[index].total)"

        return cell
    }
    
//    func submit(result: ) {
//        scores.append(result)
//        let count = scores.count
//        let indexPath = IndexPath(row: count - 1, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
//        print(scores.count)
//    }
    
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            scores.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    

}
