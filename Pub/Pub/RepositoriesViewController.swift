
import UIKit

class RepositoriesViewController: UITableViewController {
    
    var titles = [
        "Big Boss",
        "Big Boss",
        "Big Boss"
    ]
    
    var urls = [
        "http://apt.thebigboss.org/repofiles/cydia/",
        "http://apt.thebigboss.org/repofiles/cydia/",
        "http://apt.thebigboss.org/repofiles/cydia/"
    ]
    
    override func viewDidLoad() {
        title = "Repositories"
        navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = titles[indexPath.row]
        cell.detailTextLabel!.text = urls[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
            case .Delete:
                self.titles.removeAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            default:
                return
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    @IBAction func add(sender: AnyObject) {
        let alert = UIAlertController(title: "Add Repository", message: "Enter the repository's URL below.", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "URL"
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            print("Text field: \(textField.text)")
        }))
        
        presentViewController(alert, animated: true, completion: nil)
    }
}