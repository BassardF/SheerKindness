import UIKit

class SendViewController: UIViewController {
    var type : String = ""
    
    @IBOutlet var warningMsg: UILabel!
    @IBOutlet var titleType: UILabel!
    @IBOutlet var textArea: UITextView!
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    override func viewWillAppear(animated: Bool) {
        titleType.text = type
        sendButton.enabled = false
        textArea.becomeFirstResponder()
        
        warningMsg.hidden = false
        titleType.hidden = false
        textArea.hidden = false
        sendButton.hidden = false
        spinner.hidden = true
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        let id = UIDevice.currentDevice().identifierForVendor!.UUIDString
        let msg : Msg = Msg(t: type, c: textArea.text, id: id)
        let defaults = NSUserDefaults.standardUserDefaults()
        let name = defaults.stringForKey("name")
        
        warningMsg.hidden = true
        titleType.hidden = true
        textArea.hidden = true
        sendButton.hidden = true
        spinner.hidden = false
        
        FirebaseServices.writePost(msg, name: name!, callback: postSend)
    }
    
    func postSend(bool : Bool){
        var title1 = "Sent !"
        var message = "Thank you, we will give your words to someone who needs it"
        var action = "Nice"
        if(!bool){
            title1 = "Sorry"
            message = "Sorry, we encounter a probem on our side, please try again later !"
            action = "Got it"
        }
        let alert = UIAlertController(title: title1, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.Default, handler: unwind))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func unwind(alert : UIAlertAction){
        navigationController!.popViewControllerAnimated(true)
    }
    
    func textViewDidChange(textView: UITextView) {
        let count = textView.text.characters.count
        if(count >= 10){
            warningMsg.text = " Awesome, Thank you !"
            sendButton.enabled = true
        } else {
            warningMsg.text = " > 10 characters in your kind note please"
            sendButton.enabled = false
        }
    }
}
