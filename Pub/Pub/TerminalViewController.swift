
import UIKit

class TerminalViewController: UIViewController {
    
    @IBOutlet var output: UITextView!
    
    override func viewDidLoad() {
        
        if install() {
            let alert = UIAlertController(title: "Success", message: "App installed successfully.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Cancel, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
            
            let isTweak = true
            if isTweak {
                navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Respring", style: .Plain, target: self, action: "respring")
            }
            
        } else {
            
            let alert = UIAlertController(title: "Success", message: "App installed successfully.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Cancel, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "done")
    }
    
    func install() -> Bool {
        output.text = "Cloning into 'cydia'\nfatal: repository 'http://bigboss.com/sources/cydia' not found"
        
        return true
    }
    
    @IBAction func cancel() {
        print("Cancelled")
        cleanup()
        
        let alert = UIAlertController(title: "Error", message: "Pub could not install the app because the install was cancelled.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func done() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func respring() {
        // Respring
    }
    
    func cleanup() {
        // Remove extraneous files
    }
}