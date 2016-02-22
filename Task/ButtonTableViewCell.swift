//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Daniel Dickson on 2/13/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

@IBDesignable

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    var delegate: ButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func checkBoxButtonTapped(sender: AnyObject) {
        if let delegate = delegate {
            delegate.buttonCellButtonTapped(self)
        }
    }
    
    func updateButton(isComplete: Bool) {
        if isComplete {
            checkBoxButton.setImage(UIImage(named: "complete"), forState: .Normal)
        } else {
            checkBoxButton.setImage(UIImage(named: "incomplete"), forState: .Normal)
        }
    }
}

protocol ButtonTableViewCellDelegate{
    func buttonCellButtonTapped(sender: ButtonTableViewCell)
}

extension ButtonTableViewCell {
    
    func updateWithTask(task: Task) {
        primaryLabel.text = task.name
        updateButton(task.isComplete!.boolValue)
    }
}
