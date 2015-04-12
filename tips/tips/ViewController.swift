//
//  ViewController.swift
//  tips
//
//  Created by Chris Beale on 4/11/15.
//  Copyright (c) 2015 Chris Beale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var tipPercentages = [0.18, 0.2, 0.25]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }
    
    override func viewWillAppear(animated: Bool) {
        var defaults = NSUserDefaults.standardUserDefaults()
        var lowTipValue = defaults.integerForKey("lower_tip_value")
        var standardTipValue = defaults.integerForKey("standard_tip_value")
        var highTipValue = defaults.integerForKey("higher_tip_value")
        
        tipControl.setTitle("\(lowTipValue)%", forSegmentAtIndex: 0)
        tipControl.setTitle("\(standardTipValue)%", forSegmentAtIndex: 1)
        tipControl.setTitle("\(highTipValue)%", forSegmentAtIndex: 2)
        
        tipPercentages[0] = Double(lowTipValue)/100.0
        tipPercentages[1] = Double(standardTipValue)/100.0
        tipPercentages[2] = Double(highTipValue)/100.0
        
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var billAmount = (billField.text as NSString).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

