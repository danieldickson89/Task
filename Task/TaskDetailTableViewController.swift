//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Daniel Dickson on 2/11/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    var task: Task?
    var dueDateValue: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let task = task {
            updateWithTask(task)
        }
        dueTextField.inputView = dueDatePicker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTask() {
        let name = nameTextField.text!
        let due = dueDateValue
        let notes = notesTextView.text
        
        if let task = self.task {
            task.name = name
            task.due = due
            task.notes = notes
        } else {
            let newTask = Task(name: name, notes: notes, due: due)
            TaskController.sharedController.addTask(newTask)
        }
    }
    
    func updateWithTask(task: Task) {
        self.task = task
        
        title = task.name
        nameTextField.text = task.name
        
        if let dueDate = task.due {
            dueTextField.text = dueDate.stringValue()
        }
        if let notes = task.notes {
            notesTextView.text = notes
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func saveButtonTapped(sender: AnyObject) {
        updateTask()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        dueDatePicker.minimumDate = NSDate()
        self.dueTextField.text = sender.date.stringValue()
        self.dueDateValue = sender.date
    }
    
    @IBAction func usesrTappedView(sender: AnyObject) {
        self.nameTextField.resignFirstResponder()
        self.dueTextField.resignFirstResponder()
        self.notesTextView.resignFirstResponder()
    }
    
}
