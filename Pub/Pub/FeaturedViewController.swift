
import UIKit
import QuartzCore

class FeaturedViewController: UITableViewController {
    
    //@IBOutlet var shimmeringView: FBShimmeringView!
    
    @IBOutlet var scrollview1: UIScrollView!
    @IBOutlet var scrollview2: UIScrollView!
    @IBOutlet var scrollview3: UIScrollView!
    
    override func viewDidLoad() {
        
        tabBarController?.tabBar.tintColor = UIColor(red:0.61, green:0.23, blue:0.98, alpha:1.00)

        row(scrollview1)
        row(scrollview2)
        row(scrollview3)
        
    }
    
    func row(scrollView: UIScrollView) {
        let icons = [
            UIImage(named: "Cydia.jpg"),
            UIImage(named: "Cydia.jpg"),
            UIImage(named: "Cydia.jpg"),
            UIImage(named: "Cydia.jpg"),
            UIImage(named: "Cydia.jpg"),
            UIImage(named: "Cydia.jpg")
        ]
        
        let iconWidth: CGFloat = 80
        let iconHeight: CGFloat = 80
        var iconX: CGFloat = 15
        let iconY: CGFloat = 15
        var scrollViewContentSize: CGFloat = 0
        
        for icon in icons {
            
            let button = UIButton()
            button.setImage(icon, forState: .Normal)
            button.frame.size.width = iconWidth
            button.frame.size.height = iconHeight
            button.frame.origin.x = iconX
            button.frame.origin.y = iconY
            button.addTarget(self, action: "open", forControlEvents: .TouchUpInside)
            scrollView.addSubview(button)
            
            let nameLabel = UILabel()
            nameLabel.text = "Cydia"
            nameLabel.frame.size.width = iconWidth
            nameLabel.frame.size.height = 20
            nameLabel.frame.origin.x = iconX
            nameLabel.frame.origin.y = 104
            nameLabel.font = nameLabel.font.fontWithSize(14)
            scrollView.addSubview(nameLabel)
            
            let extraLabel = UILabel()
            extraLabel.text = "saurik\nFree"
            extraLabel.frame.size.width = iconWidth
            extraLabel.frame.size.height = 40
            extraLabel.textColor = UIColor.grayColor()
            extraLabel.frame.origin.x = iconX
            extraLabel.frame.origin.y = 120
            extraLabel.font = extraLabel.font.fontWithSize(14)
            extraLabel.numberOfLines = 0
            scrollView.addSubview(extraLabel)
            
            iconX += iconWidth + 15
            scrollViewContentSize += iconWidth + 15
            
            scrollView.contentSize = CGSize(width: scrollViewContentSize, height: iconHeight)
            
        }
        scrollViewContentSize += 15
        scrollView.contentSize = CGSize(width: scrollViewContentSize, height: iconHeight)
    }
    
    func open() {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("App") as! AppViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}