//
//  DonateViewController.swift
//  SpareChange
//
//  Created by Timothy Horng on 9/19/15.
//  Copyright © 2015 Timothy Horng. All rights reserved.
//

import UIKit
import QuartzCore

class DonateViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var numericDisplay: UILabel!
    @IBOutlet weak var totalAmountDonatedLabel: UILabel!
    
    @IBOutlet weak var coinChooserScrollView: UIScrollView!
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var totalAmountDonated = 0
    
    var displayLink: CADisplayLink!
    var lastDisplayLinkTimeStamp: CFTimeInterval!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // countdown timer shit
        // ---------------------------
        
        self.numericDisplay.text = "0.00"
        
        // Initializing the display link and directing it to call our displayLinkUpdate: method when an update is available //
        self.displayLink = CADisplayLink(target: self, selector: "displayLinkUpdate:")
        
        // Ensure that the display link is initially not updating //
        self.displayLink.paused = true;
        
        // Scheduling the Display Link to Send Notifications //
        self.displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        
        // Initial timestamp //
        self.lastDisplayLinkTimeStamp = self.displayLink.timestamp
        
        //-----------------------------
        
        // scrollview shit
        self.coinChooserScrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        let coinChooserScrollViewWidth:CGFloat = self.coinChooserScrollView.frame.width
        let coinChooserScrollViewHeight:CGFloat = self.coinChooserScrollView.frame.height
 
        let imgOne = UIImageView(frame: CGRectMake(0, 0,coinChooserScrollViewWidth, coinChooserScrollViewHeight))
        imgOne.image = UIImage(named: "Slide 1")
        let imgTwo = UIImageView(frame: CGRectMake(coinChooserScrollViewWidth, 0,coinChooserScrollViewWidth, coinChooserScrollViewHeight))
        imgTwo.image = UIImage(named: "Slide 2")
        let imgThree = UIImageView(frame: CGRectMake(coinChooserScrollViewWidth*2, 0,coinChooserScrollViewWidth, coinChooserScrollViewHeight))
        imgThree.image = UIImage(named: "Slide 3")
        let imgFour = UIImageView(frame: CGRectMake(coinChooserScrollViewWidth*3, 0,coinChooserScrollViewWidth, coinChooserScrollViewHeight))
        imgFour.image = UIImage(named: "Slide 4")
        
        self.coinChooserScrollView.addSubview(imgOne)
        self.coinChooserScrollView.addSubview(imgTwo)
        self.coinChooserScrollView.addSubview(imgThree)
        self.coinChooserScrollView.addSubview(imgFour)

        self.coinChooserScrollView.contentSize = CGSizeMake(self.coinChooserScrollView.frame.width * 4, self.coinChooserScrollView.frame.height)
        self.coinChooserScrollView.delegate = self

        self.pageControl.currentPage = 0

    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
        if Int(currentPage) == 0{
        }else if Int(currentPage) == 1{
        }else if Int(currentPage) == 2{
        }else{
            // Show the "Let's Start" button in the last slide (with a fade in animation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donateButtonPressed(sender: UIButton) {
        
        totalAmountDonated++
        
        totalAmountDonatedLabel.text = "Total: \(totalAmountDonated) cents"
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func displayLinkUpdate(sender: CADisplayLink) {
        // Update running tally //
        self.lastDisplayLinkTimeStamp = self.lastDisplayLinkTimeStamp + self.displayLink.duration
        
        // Format the running tally to display on the last two significant digits //
        let formattedString:String = String(format: "%0.2f", self.lastDisplayLinkTimeStamp)
        
        // Display the formatted running tally //
        self.numericDisplay.text = formattedString;
    }

}

