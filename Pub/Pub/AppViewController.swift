
import UIKit

class AppViewController: UITableViewController {
    
    @IBOutlet var overviewActivity: UIActivityIndicatorView!
    @IBOutlet var overviewIcon: UIImageView!
    @IBOutlet var overviewName: UILabel!
    @IBOutlet var overviewSeller: UILabel!
    @IBOutlet var overviewVersion: UILabel!
    @IBOutlet var overviewCategoryPrice: UILabel!
    
    @IBOutlet var install: UIButton!
    @IBOutlet var update: UIButton!
    
    @IBOutlet var screenshotsScrollView: UIScrollView!
    
    @IBOutlet var descriptionOutlet: UILabel!
    
    @IBOutlet var sizeOutlet: UILabel!
    @IBOutlet var updatedOutlet: UILabel!
    @IBOutlet var repositoryOutlet: UILabel!
    
    override func viewDidLoad() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: nil, action: nil)
        
        // Check if app exists in current repos? ----------------------------------------------------------------------------------------------------

        let appRepoInstalled = true
        
        if !appRepoInstalled {
            print("App repo not installed.")
        }
        
        // Scan filesystem to see if app is installed ----------------------------------------------------------------------------------------------------
        
        let installed = true
        
        // Pull repo to see if update is available (based on version?) ----------------------------------------------------------------------------------------------------
        
        let updateAvailable = true
        
        // Check central server to see if user owns app already ----------------------------------------------------------------------------------------------------
        
        let userOwns = false
        
        // Pull repo to see if update is available (based on version?) ----------------------------------------------------------------------------------------------------
        
        let name        = "Cydia"
        let seller      = "saurik"
        let description = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
        let category    = "Utilities"
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
        
        // Update UI ----------------------------------------------------------------------------------------------------
        
        loadIcon(icon)
        
        overviewName.text = name
        overviewSeller.text = seller
        overviewVersion.text = "v\(version)"
        
        let priceString: String
        if price == 0 {
            priceString = "Free"
        } else {
            priceString = "$\(price)"
        }
        
        overviewCategoryPrice.text = "\(category)\n\(priceString)"
        
        loadScreenshots(screenshots)
        
        descriptionOutlet.text = description
        
        sizeOutlet.text = "\(size/1024/1024) MB"
        updatedOutlet.text = updated
        repositoryOutlet.text = repository
        
        // Buttons ----------------------------------------------------------------------------------------------------
        
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
            
            if (price <= 0) {
                print("App is free.")
                install.setImage(UIImage(named: "Install"), forState: .Normal)
            } else {
                print("App is not free.")
                if (userOwns) {
                    print("User owns this app already.")
                    install.setImage(UIImage(named: "Install"), forState: .Normal)
                } else {
                    print("User does not own this app already.")
                    install.setImage(UIImage(named: "Buy"), forState: .Normal)
                }
            }
        }
    }
    
    // Functions ----------------------------------------------------------------------------------------------------
    
    func loadIcon(url: String) {
        
        /*
        let imageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        imageView.backgroundColor = UIColor.redColor()
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        */

        overviewActivity.startAnimating()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: NSURL(string: url)!)
            dispatch_async(dispatch_get_main_queue(), {
                self.overviewActivity.stopAnimating()
                self.overviewIcon.image = UIImage(data: data!)!
            });
        }
    }
    
    func loadScreenshots(urls: [String]) {
        
        let screenshotWidth: CGFloat = 130
        let screenshotHeight: CGFloat = 232
        var screenshotX: CGFloat = 15
        let screenshotY: CGFloat = 15
        var scrollViewContentSize: CGFloat = 0
        
        let screenshotActivity = UIActivityIndicatorView()
        
        for url in urls {
            
            screenshotActivity.frame.origin.y = 120
            screenshotActivity.color = UIColor.grayColor()
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                
                screenshotActivity.frame.origin.x = screenshotX + 55
                
                self.screenshotsScrollView.addSubview(screenshotActivity)
                screenshotActivity.startAnimating()
                
                let data = NSData(contentsOfURL: NSURL(string: url)!)
                dispatch_async(dispatch_get_main_queue(), {
                    
                    let button = UIButton()
                    button.setImage(UIImage(data: data!)!, forState: UIControlState.Normal)
                    button.frame.size.width = screenshotWidth
                    button.frame.size.height = screenshotHeight
                    button.frame.origin.x = screenshotX
                    button.frame.origin.y = screenshotY
                    button.addTarget(self, action: "openScreenshot", forControlEvents: .TouchUpInside)
                    self.screenshotsScrollView.addSubview(button)
                    
                    screenshotX += screenshotWidth + 15
                    scrollViewContentSize += screenshotWidth + 15
                    
                    screenshotActivity.frame.origin.x = screenshotX + 55
                    
                    self.screenshotsScrollView.addSubview(screenshotActivity)
                    
                    self.screenshotsScrollView.contentSize = CGSize(width: scrollViewContentSize, height: screenshotHeight)
                });
            }
        }
        screenshotActivity.stopAnimating()
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
    
    // Actions ----------------------------------------------------------------------------------------------------
    
    @IBAction func updateAction() {
        print("Update")
        let vc = storyboard?.instantiateViewControllerWithIdentifier("Console Navigation") as! UINavigationController
        presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func install(sender: AnyObject) {
        let alert = UIAlertController(title: "Confirm Removal", message: "Are you sure you want to delete this app? This action is irreversible.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Remove", style: .Default, handler: { (action) -> Void in
            print("Remove")
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Console Navigation") as! UINavigationController
            self.presentViewController(vc, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
}
