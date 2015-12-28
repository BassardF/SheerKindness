import UIKit

class FetchViewController: UIViewController {
    var type : String = ""
    
    @IBOutlet var titleType: UILabel!
    @IBOutlet var textField: UITextView!
    @IBOutlet var author: UILabel!
    @IBOutlet var thankButton: UIButton!
    @IBOutlet var reportButton: UIButton!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    var id : String = ""
    var content : NSDictionary?
    
    override func viewWillAppear(animated: Bool) {
        titleType.text = type
        FirebaseServices.readPost(type, callback: handleMessages)
        loaderOn()
    }
    
    func loaderOn(){
        textField.hidden = true
        author.hidden = true
        thankButton.hidden = true
        reportButton.hidden = true
        indicator.hidden = false
    }
    
    func loaderOff(){
        textField.hidden = false
        author.hidden = false
        thankButton.hidden = false
        reportButton.hidden = false
        indicator.hidden = true
    }
    
    func handleMessages(msgs : NSDictionary){
        var feed = false
        for (key, content) in msgs {
            feed = true
            self.id = key as! String
            let dic = content as! NSDictionary
            self.content = dic
            
            textField.text = dic.valueForKey("content") as! String
            author.text = "- " + (dic.valueForKey("name") as! String)
            
            loaderOff()
        }
        if !feed{
            emptyAlert()
        }
    }
    
    @IBAction func thank(sender: AnyObject) {
        loaderOn()
        let type = self.content!.valueForKey("type") as! String
        let content = self.content!.valueForKey("content") as! String
        let toName = self.content!.valueForKey("name") as! String
        let toId = self.content!.valueForKey("id") as! String
        let defaults = NSUserDefaults.standardUserDefaults()
        let fromName = defaults.stringForKey("name")
        let fromId = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        let thx = Thanks(type: type, content: content, fromName: fromName!, fromId: fromId, toName: toName, toId: toId)
        FirebaseServices.writeThanks(thx, callback: alert)
        FirebaseServices.deletePost(id, callback: empty)
    }
    
    @IBAction func back(sender: AnyObject) {
        let type = self.content!.valueForKey("type") as! String
        let content = self.content!.valueForKey("content") as! String
        let toName = self.content!.valueForKey("name") as! String
        let toId = self.content!.valueForKey("id") as! String
        let defaults = NSUserDefaults.standardUserDefaults()
        let fromName = defaults.stringForKey("name")
        let fromId = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        let thx = Thanks(type: type, content: content, fromName: fromName!, fromId: fromId, toName: toName, toId: toId)
        FirebaseServices.writeThankLess(thx, callback: alert)
        FirebaseServices.deletePost(id, callback: empty)
    }
    
    @IBAction func report(sender: AnyObject) {
        loaderOn()
        let type = self.content!.valueForKey("type") as! String
        let content = self.content!.valueForKey("content") as! String
        let toName = self.content!.valueForKey("name") as! String
        let toId = self.content!.valueForKey("id") as! String
        let defaults = NSUserDefaults.standardUserDefaults()
        let fromName = defaults.stringForKey("name")
        let fromId = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        let thx = Thanks(type: type, content: content, fromName: fromName!, fromId: fromId, toName: toName, toId: toId)
        FirebaseServices.writeReport(thx, callback: alert)
        FirebaseServices.deletePost(id, callback: empty)
    }
    
    func alert(bool : Bool){
        var title1 = "Feeback sent"
        var message = "Thank you for your feedback"
        var action = "Ok"
        if(!bool){
            title1 = "Sorry"
            message = "Sorry, we encounter a probem on our side, please try again later !"
            action = "Got it"
        }
        loaderOff()
        let alert = UIAlertController(title: title1, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.Default, handler: unwind))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func emptyAlert(){
        let title1 = "Empty stocks"
        let message = "Sorry, we don't have any messages available in that category right now"
        let action = "Ok"
        let alert = UIAlertController(title: title1, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.Default, handler: unwind))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func unwind(alert : UIAlertAction){
        navigationController!.popViewControllerAnimated(true)
    }
    
    func empty(bool : Bool){
    }
    
}
