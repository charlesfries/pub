
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
        return cell
    }
}