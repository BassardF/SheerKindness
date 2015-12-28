import UIKit

class ThanksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    var thanks : [Thanks] = []
    
    override func viewWillAppear(animated: Bool) {
        
        let id = UIDevice.currentDevice().identifierForVendor!.UUIDString
        FirebaseServices.readThanks(id, callback: handleThanks)
        
        spinner.hidden = false
        tableView.hidden = true
        
    }
    
    func handleThanks(thks : NSDictionary){
        self.thanks = []
        var bool = false
        for (_, content) in thks {
            let dic = content as! NSDictionary
            let type = dic.valueForKey("type") as! String
            let content = dic.valueForKey("content") as! String
            let fromName = dic.valueForKey("fromName") as! String
            let fromId = dic.valueForKey("fromId") as! String
            let toName = dic.valueForKey("toName") as! String
            let toId = dic.valueForKey("toId") as! String
            
            let thx = Thanks(type: type, content: content, fromName: fromName, fromId: fromId, toName: toName, toId: toId)
            self.thanks.append(thx)
            bool = true
        }
        tableView.reloadData()
        spinner.hidden = true
        tableView.hidden = false
        if !bool{
            noThxYet()
        }
    }
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.thanks.count
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let innDate = self.thanks[indexPath.row].date
        let dayTimePeriodFormatter = NSDateFormatter()
        dayTimePeriodFormatter.dateFormat = "d MMM yyyy"
        let dateString = dayTimePeriodFormatter.stringFromDate(innDate)
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Thxcell")! as UITableViewCell
        cell.textLabel?.text = "Thank you !"
        cell.detailTextLabel?.text = dateString + " - " + self.thanks[indexPath.row].fromName
        return cell
    }
    
    func noThxYet(){
        let title1 = "No feedback yet"
        let message = "You don't have any feeback yet, wait for people to read your messages :)"
        let action = "Alright"
        let alert = UIAlertController(title: title1, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.Default, handler: empty))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func empty(alert : UIAlertAction){
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let title1 = self.thanks[indexPath.row].fromName + " thanked you for :"
        let message = self.thanks[indexPath.row].content
        let action = "Nice"
        let alert = UIAlertController(title: title1, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.Default, handler: empty))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
