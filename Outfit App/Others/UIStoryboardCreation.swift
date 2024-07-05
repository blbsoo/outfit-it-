//
//  InvokeViewController.swift
//  DeliveryApp
//
//  Created by MacAdmin on 17/04/20.
//  Copyright © 2020 Harsh. All rights reserved.
//

import UIKit

class UIStoryboardCreation {
    
    static func instinateStoryboard(storyboardName:String)-> UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
       }
    
    static func loadStartupVC() -> StartupVC {
              let storyboard = instinateStoryboard(storyboardName: storyboardIdentifier.main)
        return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier.startup) as! StartupVC
          }
    
    static func loadLoginVC() -> LoginVC {
              let storyboard = instinateStoryboard(storyboardName: storyboardIdentifier.main)
        return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier.login) as! LoginVC
          }
    
    static func loadSignup() -> SignupVC {
              let storyboard = instinateStoryboard(storyboardName: storyboardIdentifier.main)
        return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier.signup) as! SignupVC
          }
    
    static func loadResetPassword() -> ResetPasswordVC {
              let storyboard = instinateStoryboard(storyboardName: storyboardIdentifier.main)
        return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier.resetPassword) as! ResetPasswordVC
          }
    
    static func loadUsersListVC() -> UsersListVC {
              let storyboard = instinateStoryboard(storyboardName: storyboardIdentifier.home)
        return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier.usersList) as! UsersListVC
          }
    
    static func loadUsersMessagesListVC() -> UsersMessagesListVC {
              let storyboard = instinateStoryboard(storyboardName: storyboardIdentifier.home)
        return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier.usersMessagesList) as! UsersMessagesListVC
          }
    
    
    static func loadUserProfile() -> userProfileVC {
              let storyboard = instinateStoryboard(storyboardName: storyboardIdentifier.home)
        return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier.userProfile) as! userProfileVC
          }
    
    static func loadUserProfileDetailVC() -> UserProfileDetailVC {
              let storyboard = instinateStoryboard(storyboardName: storyboardIdentifier.home)
        return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier.userDetailProfile) as! UserProfileDetailVC
          }

    static func loadTabBarVC()-> tabBarController {
    let storyboard = instinateStoryboard(storyboardName: storyboardIdentifier.home)
    return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier.tabBarVC) as! tabBarController
    }
    
    static func loadChatViewMessages()-> ChatViewMessagesVC {
        let storyboard = instinateStoryboard(storyboardName: storyboardIdentifier.home)
        return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier.ChatMessagesVC) as! ChatViewMessagesVC
        }
    
}
