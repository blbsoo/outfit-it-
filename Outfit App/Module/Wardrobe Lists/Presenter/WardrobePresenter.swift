//
//  WardrobePresenter.swift
//  Outfit App
//
//  Created by Krishna Sharma on 30/11/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

protocol WardrobeListProtocol {
    
    func handleUploadImageResponse(imageURL:String?, failure:String?)
    func handleWardrobeListResponse(bottomList:[String]?, topsList:[String]?, shoesList:[String]?, failure:String?)
    func handleSetWardrobeResponse(response:String?, failure:String?)
    
}

class WardrobePresenter: NSObject {
    
    var delegate:WardrobeListProtocol!
    
    func generateTimeStamp()-> String {
        let date = Date()
        let format = DateFormatter()
        format.timeZone = TimeZone(abbreviation: "UTC")
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return format.string(from: date)
    }
    
    func fetchBottomsItems(type:String, userID:String) {
        
        let ref = DatabaseConnectionManager().databaseRef()
        ref.child(firebaseNodes.Wardrobe).child(userID).observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? [String:Any] {
              
                var tempBottom = [String]()
                var tempTops = [String]()
                var shoes = [String]()
                
                if let bottom = value["BottomClothes"] as?[String:Any], let images = bottom["Images"] {
                    tempBottom = images as! [String]
                }
                
                if let bottom = value["Tops"] as?[String:Any], let images = bottom["Images"] {
                    tempTops = images as! [String]
                }
                
                if let bottom = value["Shoes"] as?[String:Any], let images = bottom["Images"] {
                    shoes = images as! [String]
                }
                
                self.delegate.handleWardrobeListResponse(bottomList: tempBottom, topsList: tempTops, shoesList: shoes, failure: nil)
            } else {
    self.delegate.handleWardrobeListResponse(bottomList: nil, topsList: nil, shoesList: nil, failure: "No Data")
            }
        }
    }

    func setWardrobeItems(type:String, userID:String, image:[String]) {
        let ref = DatabaseConnectionManager().databaseRef()
        ref.root.child(firebaseNodes.Wardrobe).child(userID).child(type).setValue(["Images":image]) { (error, snapshot) in
            if error == nil {
        self.delegate?.handleSetWardrobeResponse(response: "Success", failure: nil)
            } else {
        self.delegate?.handleSetWardrobeResponse(response: nil, failure: error?.localizedDescription)
            }
        }
    }
    
    
    func uploadImage(image:UIImage, userID:String, type:String){
        let storage = Storage.storage()
          let imageName = self.generateTimeStamp() + ".png"
        let imageRef = storage.reference().child(type).child(imageName)
        
        print(imageName)
        print(imageRef)
        if let uploadData = image.jpegData(compressionQuality: 0.3) {
            imageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error == nil {
                    guard let metadata = metadata else {
                        // Uh-oh, an error occurred!
                        return
                      }
        imageRef.downloadURL { (url, error) in
        print(url?.absoluteString)
                        if error == nil {
    self.delegate?.handleUploadImageResponse(imageURL: url?.absoluteString, failure: nil)
                        } else {
    self.delegate?.handleUploadImageResponse(imageURL: nil, failure: error?.localizedDescription)
                        }
                    }
                } else {
    self.delegate?.handleUploadImageResponse(imageURL: nil, failure: error?.localizedDescription)
                }
            }
        }
        
    }
    
    
    
    
}
