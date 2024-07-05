

import UIKit

class userProfileVC: UIViewController {

    @IBAction func didTapChat(_ sender: Any) {
        let viewc = UIStoryboardCreation.loadUsersMessagesListVC()
        self.navigationController?.pushViewController(viewc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
