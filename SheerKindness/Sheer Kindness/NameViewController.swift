import UIKit

class NameViewController: UIViewController {
    
    
    @IBOutlet var nickname: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        nickname.becomeFirstResponder()
    }
    
    @IBAction func done(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(nickname.text, forKey: "name")
        navigationController!.popViewControllerAnimated(true)
    }
    
}