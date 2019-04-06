
import UIKit

class InstalledViewController: UITableViewController {
    
    var titles = [
        "Cydia",
        "Barrel Roll",
        "NumPad"
    ]
    
    var authors = [
        "saurik",
        "itweakz",
        "charlesfries"
    ]
    
    override func viewDidLoad() {
        title = "Installed"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = titles[indexPath.row]
        cell.detailTextLabel!.text = authors[indexPath.row]
        cell.imageView!.image = scaleUIImageToSize(UIImage(named: "Cydia.jpg")!, size: CGSize(width: 30, height: 30))
        return cell
    }
    
    func scaleUIImageToSize(let image: UIImage, let size: CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}