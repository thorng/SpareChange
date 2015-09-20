//
//  DonateViewController.swift
//  SpareChange
//
//  Created by Timothy Horng on 9/19/15.
//  Copyright © 2015 Timothy Horng. All rights reserved.
//

import UIKit
import QuartzCore
import CoreData

class DonateViewController: UIViewController, CountdownTimerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var damageLabel: UILabel!
    
    @IBOutlet weak var dragonImage: UIImageView!
    @IBOutlet weak var swordImage: UIImageView!

    @IBOutlet weak var totalAmountDonatedLabel: UILabel!
    
//    let sword1 = UIImage(named: "sword1")
//    let sword2 = UIImage(named: "sword2")
//    let sword3 = UIImage(named: "sword3")
    
    let images = [UIImage(named: "sword1"), UIImage(named: "sword2"), UIImage(named: "sword3")]
    
    @IBOutlet weak var coinChooserScrollView: UIScrollView!
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var timeLabel: UILabel!
    var timer: CountdownTimer!
    
    var currentTime = mach_absolute_time()
    
    var amountSelected = 1
    
    var totalAmountDonated = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        damageLabel.text = ""
        damageLabel.hidden = true
        
        //CapitalOneNetwork.callAPI()
        totalAmountDonatedLabel.text = "Total: $0.00"

        // countdown timer shit
        // ---------------------------
        
        timer = CountdownTimer(timerLabel: timeLabel, startingMin: 1, startingSec: 0)
        timer.delegate = self
        
        timer.start()
        
        //-----------------------------
        
        // scrollview shit
        let coinChooserScrollViewWidth:CGFloat = self.coinChooserScrollView.frame.width
        let coinChooserScrollViewHeight:CGFloat = self.coinChooserScrollView.frame.height
 
        let imgOne = UIImageView(frame: CGRectMake(0, 0,coinChooserScrollViewWidth, coinChooserScrollViewHeight))
        imgOne.contentMode = UIViewContentMode.ScaleAspectFit
        imgOne.image = UIImage(named: "penny")
        
        let imgTwo = UIImageView(frame: CGRectMake(coinChooserScrollViewWidth, 0,coinChooserScrollViewWidth, coinChooserScrollViewHeight))
        imgTwo.contentMode = UIViewContentMode.ScaleAspectFit
        imgTwo.image = UIImage(named: "nickel")
        
        let imgThree = UIImageView(frame: CGRectMake(coinChooserScrollViewWidth*2, 0,coinChooserScrollViewWidth, coinChooserScrollViewHeight))
        imgThree.contentMode = UIViewContentMode.ScaleAspectFit
        imgThree.image = UIImage(named: "dime")
        
        
        let imgFour = UIImageView(frame: CGRectMake(coinChooserScrollViewWidth*3, 0,coinChooserScrollViewWidth, coinChooserScrollViewHeight))
        imgFour.contentMode = UIViewContentMode.ScaleAspectFit
        imgFour.image = UIImage(named: "quarter")
        
        let imgFive = UIImageView(frame: CGRectMake(coinChooserScrollViewWidth*4, 0,coinChooserScrollViewWidth, coinChooserScrollViewHeight))
        imgFive.contentMode = UIViewContentMode.ScaleAspectFit
        imgFive.image = UIImage(named: "dollar")
        
        self.coinChooserScrollView.addSubview(imgOne)
        self.coinChooserScrollView.addSubview(imgTwo)
        self.coinChooserScrollView.addSubview(imgThree)
        self.coinChooserScrollView.addSubview(imgFour)
        self.coinChooserScrollView.addSubview(imgFive)

        self.coinChooserScrollView.contentSize = CGSizeMake(self.coinChooserScrollView.frame.width * 5, self.coinChooserScrollView.frame.height)
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
            amountSelected = 1
        }else if Int(currentPage) == 1{
            amountSelected = 5
        }else if Int(currentPage) == 2{
            amountSelected = 10
        }else if Int(currentPage) == 3{
            amountSelected = 25
        }else if Int(currentPage) == 4{
            amountSelected = 100
        }
        
        damageLabel.text = "-\(amountSelected)"
    }
    
    func countdownEnded() -> Void {
        timer.reset()
        timer.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donateButtonPressed(sender: UIButton) {
        
        index = 0
        
        damageLabel.alpha = 1.0
        damageLabel.text = "-\(amountSelected)"
        damageLabel.hidden = false
        damageRiseUp()
        fadeOut()
        
        animateImageView()
        
        self.bounceUp()
        
        totalAmountDonated += amountSelected
        
        totalAmountDonatedLabel.text = "Total: $\(Double(totalAmountDonated)/100)"
    }
    
    var index = 0
    var swingCount = 0
    
    func animateImageView() {
        
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(0.1)
        CATransaction.setCompletionBlock {[weak self] in
            if let strongSelf = self {
                //check if there are more images to display
                if strongSelf.index < strongSelf.images.count {
                    let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1))
                    dispatch_after(delay, dispatch_get_main_queue()) {
                        strongSelf.animateImageView()
                    }
                }
            }
        }
        
        let transition = CATransition()
        //transition.type = kCATransitionFade
        
        swordImage.layer.addAnimation(transition, forKey: kCATransition)
        swordImage.image = images[index]
        
        CATransaction.commit()
        //increment index
        
//        self.swordImage.animationDuration = 0.5
//        self.swordImage.startAnimating()
//        for (var i = 0; i < images.count - 1; i++) {
//            swordImage.image = images[i]
//        }
        
//        self.swordImage.animationImages = [UIImage(named: "sword1"), UIImage(named: "sword2"), UIImage(named: "sword3")]
//        self.swordImage.animationDuration = 0.1
//        self.swordImage.startAnimating()
        
        index++
        
        swingCount++
        
        if swingCount == 3 {
            swingCount = 0
        }
    }
    
    func bounceDown() {
        UIView.animateWithDuration(0.1, animations:{
            self.dragonImage.frame = CGRect(x: self.dragonImage.frame.origin.x, y: self.dragonImage.frame.origin.y + 50, width: self.dragonImage.frame.size.width, height: self.dragonImage.frame.size.height)
            }, completion: { animationFinished in
        })
    }
    
    func bounceUp() {
        UIView.animateWithDuration(0.1, animations:{
            self.dragonImage.frame = CGRect(x: self.dragonImage.frame.origin.x, y: self.dragonImage.frame.origin.y - 50, width: self.dragonImage.frame.size.width, height: self.dragonImage.frame.size.height)
            }, completion: { animationFinished in
                self.bounceDown()
        })
    }
    
    func damageRiseUp() {
        UIView.animateWithDuration(1.0, animations:{
            self.damageLabel.frame = CGRect(x: self.damageLabel.frame.origin.x, y: self.damageLabel.frame.origin.y - 50, width: self.damageLabel.frame.size.width, height: self.damageLabel.frame.size.height)
        })
    }
    
    func fadeOut() {
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.damageLabel.alpha = 0.0
            }, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    func displayLinkUpdate(sender: CADisplayLink) {
//        // Update running tally //
//        self.lastDisplayLinkTimeStamp = self.lastDisplayLinkTimeStamp + self.displayLink.duration
//        
//        // Format the running tally to display on the last two significant digits //
//        let formattedString:String = String(format: "%0.2f", self.lastDisplayLinkTimeStamp)
//        
//        // Display the formatted running tally //
//        self.numericDisplay.text = formattedString;
//    }

}

