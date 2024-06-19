//
//  AppStoryboard.swift
//  PHN
//
//  Created by PHN Tech 2 on 20/12/23.
//

import UIKit

enum AppStoryboard: String {
    case launch  = "LaunchScreen"
    case main = "Main"
    
    private var instance: UIStoryboard{
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardId = String(describing: viewControllerClass)
        guard let viewController = instance.instantiateViewController(withIdentifier: storyboardId) as? T else{
            fatalError("In this Storyboard:- \(storyboardId),that VC:- \(T.description()) Not Found")
        }
       return viewController
    }
}
