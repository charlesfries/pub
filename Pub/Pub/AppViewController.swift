
import UIKit

class AppViewController: UITableViewController {
    
    @IBOutlet var activity: UIActivityIndicatorView!
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var nameView: UILabel!
    @IBOutlet var sellerView: UILabel!
    
    @IBOutlet var install: UIButton!
    @IBOutlet var update: UIButton!
    
    @IBOutlet var screenshotsScrollView: UIScrollView!
    
    @IBOutlet var descriptionOutlet: UILabel!
    
    @IBOutlet var nameOutlet: UILabel!
    @IBOutlet var sellerOutlet: UILabel!
    @IBOutlet var priceOutlet: UILabel!
    @IBOutlet var versionOutlet: UILabel!
    @IBOutlet var sizeOutlet: UILabel!
    @IBOutlet var updatedOutlet: UILabel!
    @IBOutlet var repositoryOutlet: UILabel!
    
    override func viewDidLoad() {

        let appRepoInstalled = false
        
        if !appRepoInstalled {
            print("App repo not installed.")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: nil, action: nil)
        
        // Repository Data ----------------------------------------------------------------------------------------------------
        
        let name        = "Cydia"
        let seller      = "saurik"
        let description = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
        let price       = 1.99
        let version     = "1.0"
        let size        = 29464985
        let updated     = "Apr 4, 2016"
        let repository  = "Big Boss"
        let icon        = "http://www.ijailbreak.com/wp-content/uploads/2013/12/iOS-7-Cydia-Icon-2.jpg"
        let screenshots = [
            "http://www.iclarified.com/images/news/37060/159438/159438.png",
            "http://wpuploads.appadvice.com/wp-content/uploads/2014/05/2014-05-12-1.34.29-00.jpg",
            "http://www.iclarified.com/images/news/37060/159433/159433.png"
        ]
        
        let installed = false
        let updateAvailable = false
        let userOwns = false
        
        // Update UI ----------------------------------------------------------------------------------------------------
        
        
        
        
        
        
        
        
        loadIcon(icon)
        loadScreenshots(screenshots)
        
        let priceString: String
        if price == 0 {
            priceString = "Free"
        } else {
            priceString = "$\(price)"
        }
        
        title = name
        
        nameView.text = name
        sellerView.text = "\(seller)"
        
        descriptionOutlet.text = description
        
        nameOutlet.text = name
        sellerOutlet.text = seller
        priceOutlet.text = priceString
        versionOutlet.text = version
        sizeOutlet.text = "\(size/1024/1024) MB"
        updatedOutlet.text = updated
        repositoryOutlet.text = repository
        
        // Conditions ----------------------------------------------------------------------------------------------------
        if (installed) {
            print("App is already installed.")
            update.hidden = false
            install.setImage(UIImage(named: "Remove"), forState: .Normal)
            
            if (updateAvailable) {
                print("Updates are available.")
            } else {
                print("Updates are not available.")
                update.hidden = true
            }
            
        } else {
            print("App is not installed.")
            update.hidden = true
            install.setImage(UIImage(named: "Install"), forState: .Normal)
            
            if (price > 0) {
                print("App is free.")
            } else {
                print("App is not free.")
                if (userOwns) {
                    print("User owns this app already.")
                } else {
                    print("User does not own this app already.")
                }
            }
        }
    }
    
    func loadIcon(url: String) {
        activity.startAnimating()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: NSURL(string: url)!)
            dispatch_async(dispatch_get_main_queue(), {
                self.activity.stopAnimating()
                self.iconView.image = UIImage(data: data!)!
            });
        }
    }
    
    //var shots: [UIImage]!
    
    func loadScreenshots(urls: [String]) {
        let screenshotWidth: CGFloat = 130
        let screenshotHeight: CGFloat = 232
        var screenshotX: CGFloat = 15
        var scrollViewContentSize: CGFloat = 0
        
        for url in urls {
            
            let screenshotActivity = UIActivityIndicatorView()
            screenshotActivity.frame.origin.y = 120
            screenshotActivity.color = UIColor.grayColor()
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                
                screenshotActivity.frame.origin.x = screenshotX + 55
                
                self.screenshotsScrollView.addSubview(screenshotActivity)
                screenshotActivity.startAnimating()
                
                let data = NSData(contentsOfURL: NSURL(string: url)!)
                dispatch_async(dispatch_get_main_queue(), {
                    
                    //self.shots.append(UIImage(data: data!)!)
                    
                    screenshotActivity.stopAnimating()
                    
                    let button = UIButton()
                    button.setImage(UIImage(data: data!)!, forState: UIControlState.Normal)
                    button.frame.size.width = screenshotWidth
                    button.frame.size.height = screenshotHeight
                    button.frame.origin.x = screenshotX
                    button.frame.origin.y = 15
                    self.screenshotsScrollView.addSubview(button)
                    
                    button.addTarget(self, action: "openScreenshot", forControlEvents: .TouchUpInside)
                    
                    screenshotX += screenshotWidth + 15
                    scrollViewContentSize += screenshotWidth + 15
                    
                    self.screenshotsScrollView.contentSize = CGSize(width: scrollViewContentSize, height: screenshotHeight)
                });
            }
        }
        scrollViewContentSize += 15
    }
    
    func displayShareSheet() {
        let activityViewController = UIActivityViewController(activityItems: ["URL TO SHARE" as NSString], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    func openScreenshot() {
        let secondViewController = storyboard?.instantiateViewControllerWithIdentifier("Screenshots") as! ScreenshotsViewController
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let dvc = segue.destinationViewController as! ScreenshotsViewController
        dvc.screenshots = shots
    }*/
    
    
    
    
    // Actions ----------------------------------------------------------------------------------------------------
    
    @IBAction func install(sender: AnyObject) {
        print("Install")
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("myVCId") as! UINavigationController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func remove(sender: AnyObject) {
        print("Remove")
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("myVCId") as! UINavigationController
        self.presentViewController(vc, animated: true, completion: nil)
    }

}
