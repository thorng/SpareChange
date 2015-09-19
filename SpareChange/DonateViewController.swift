//
//  DonateViewController.swift
//  SpareChange
//
//  Created by Timothy Horng on 9/19/15.
//  Copyright © 2015 Timothy Horng. All rights reserved.
//

import UIKit

class DonateViewController: UIViewController {

    @IBOutlet weak var totalAmountDonatedLabel: UILabel!
    
    var totalAmountDonated = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donateButtonPressed(sender: UIButton) {
        
        totalAmountDonated++
        
        totalAmountDonatedLabel.text = "Total: \(totalAmountDonated) cents"
        print("button pressed :3")
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
