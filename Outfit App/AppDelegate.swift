
import UIKit
import Firebase
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        // Override point for customization after application launch.
        return true
    }
    
    func showAlert(title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
           }
           alertController.addAction(OKAction)
           self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
   func navigationRootViewController(storyBoardID:String, viewControllerID:String){
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController =  UIStoryboard.init(name: storyBoardID , bundle: nil).instantiateViewController(withIdentifier: viewControllerID)
        
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }
}
