
import UIKit

class ConsoleViewController: UIViewController {
    
    @IBOutlet var output: UITextView!
    
    override func viewDidLoad() {
        
        if install() {
            let alert = UIAlertView()
            alert.title = "Success"
            alert.message = "App installed successfully."
            alert.addButtonWithTitle("Okay")
            alert.show()
            
            let isTweak = true
            if isTweak {
                navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Respring", style: .Plain, target: self, action: "respring")
            }
            
        } else {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Pub could not install the app."
            alert.addButtonWithTitle("Okay")
            alert.show()
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
        
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = "Pub could not install the app because the install was cancelled."
        alert.addButtonWithTitle("Okay")
        alert.show()
        
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func done() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func respring() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cleanup() {
        // Remove extraneous files
    }
}