
import UIKit
import Firebase
import FirebaseDatabase

class DatabaseConnectionManager:NSObject {
    
    func databaseRef()->DatabaseReference {
       return Database.database().reference()
    }
    
    func firebaseConfigure() {
      FirebaseApp.configure()
    }
    
    func isOfflineAllow(isAllow:Bool) {
        Database.database().isPersistenceEnabled = isAllow
    }
    
    
    
    

}

