//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Daniel Dickson on 2/11/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {

        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.sharedController.taskArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! ButtonTableViewCell

        let task = TaskController.sharedController.taskArray[indexPath.row]
        
        cell.updateWithTask(task)
        cell.delegate = self

        return cell
    }
    

   // Allow user to edit the Task List
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete row from data source
            let task = TaskController.sharedController.taskArray[indexPath.row]
            TaskController.sharedController.removeTask(task)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toTaskDetail" {
            if let cell = sender as? UITableViewCell, indexPath = tableView.indexPathForCell(cell) {
                let task = TaskController.sharedController.taskArray[indexPath.row]
                let taskDetailTableViewController = segue.destinationViewController as? TaskDetailTableViewController
                taskDetailTableViewController?.task = task
            }
        }
    }
}

extension TaskListTableViewController: ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(sender: ButtonTableViewCell) {
        let indexPath = tableView.indexPathForCell(sender)
        
        let task = TaskController.sharedController.taskArray[indexPath!.row]
        task.isComplete = !task.isComplete!.boolValue
        TaskController.sharedController.saveToPersistence()
        tableView.reloadData()
    }
}



