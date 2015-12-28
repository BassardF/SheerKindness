import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor(red: (49/255.0), green: (142/255.0), blue: (152/255.0), alpha: 1.0)
        UITabBar.appearance().barTintColor = UIColor(red: (51/255.0), green: (51/255.0), blue: (52/255.0), alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
