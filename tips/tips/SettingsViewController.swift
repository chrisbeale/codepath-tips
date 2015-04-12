//
//  SettingsViewController.swift
//  tips
//
//  Created by Chris Beale on 4/11/15.
//  Copyright (c) 2015 Chris Beale. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var tipValuePicker: UIPickerView!
    
    let tipValues = [10, 12, 14, 16, 18, 20,
        22, 24, 26, 28, 30]
    
    var tipSettings = [0,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipValuePicker.delegate = self
        tipValuePicker.dataSource = self
        // Do any additional setup after loading the view.
        
        var defaults = NSUserDefaults.standardUserDefaults()        
        tipSettings[0] = defaults.integerForKey("lower_tip_value")
        tipSettings[1] = defaults.integerForKey("standard_tip_value")
        tipSettings[2] = defaults.integerForKey("higher_tip_value")
        
        for var i = 0; i < 3; i++ {
            var index = find(tipValues, tipSettings[i])
            tipValuePicker.selectRow(index!, inComponent: i, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onCancelClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSaveClicked(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipSettings[0], forKey: "lower_tip_value")
        defaults.setInteger(tipSettings[1], forKey: "standard_tip_value")
        defaults.setInteger(tipSettings[2], forKey: "higher_tip_value")
        defaults.synchronize()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return tipSettings.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipValues.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(tipValues[row])%"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tipSettings[component] = tipValues[row]
    }
}
