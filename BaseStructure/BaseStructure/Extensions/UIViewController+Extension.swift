//
//  UIViewController+Extension.swift
//  Field Executive
//
//  Created by PHN MAC 1 on 03/11/23.
//

import UIKit

extension UIViewController{
    func getWindow() -> UIWindow?{
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        return window
    }
    
    func showAlertMessage(title: String = "", message: String = "",handler: (()->Void)? = nil){
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel){_ in 
            if let handler{ handler() }
        }
        alertMessage.addAction(ok)
        self.present(alertMessage, animated: true)
    }
    
    func showAlertMessageForConfirmation(title: String = "", message: String = "",onYes: (()->Void)? = nil, onNo: (()->Void)? = nil){
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default){_ in
            if let onYes{ onYes() }
        }
        let no = UIAlertAction(title: "No", style: .default){_ in
            if let onNo{ onNo() }
        }
        alertMessage.addAction(no)
        alertMessage.addAction(yes)
        self.present(alertMessage, animated: true)
    }
    
    func logoutAlert(title: String = "", message: String = "",logout: (()->Void)? = nil){
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let logout = UIAlertAction(title: "Logout", style: .destructive){_ in
            if let logout{ logout() }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){_ in }
        alertMessage.addAction(logout)
        alertMessage.addAction(cancel)
        self.present(alertMessage, animated: true)
    }
    
    func showErrorAlert(handler: (()->Void)? = nil){
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            self.showAlertMessage(title:"Error", message: "Oops, seems like a glitch got in our way. Please retry your action.",handler: handler)
        })
    }
    
    func showAlertMessage(title: String = "", message: String = "",time: Double){
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertMessage, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: {
            alertMessage.dismiss(animated: true)
        })
    }
    
    func showAlertInternetConnection(){
        showAlertMessage(title:"Network Error", message: "There was an error connecting. Please check your internet.")
    }
    
    func addChildViewController(viewController: UIViewController, containerView: UIView){
        addChild(viewController)
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    
    func presentBottomSheet(height: CGFloat,viewController: UIViewController){
        let nav = UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                if #available(iOS 16.0, *) {
                    sheet.preferredCornerRadius = 24
                    sheet.detents = [.custom(resolver: { context in
                       return height
                    })]
                }
            }
        }
        present(nav, animated: true, completion: nil)
    }
    
    func presentCustomAlertVC(viewController: UIViewController){
        if let window = self.getWindow(), let rootVC = window.rootViewController{
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.modalTransitionStyle = .crossDissolve
            rootVC.present(viewController, animated: true)
        }
    }
    
    func closeViewController() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    func callNumber(phoneNumber:String) {
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                     application.openURL(phoneCallURL as URL)

                }
            }
        }
    }
    
    func addNoDataView(tableView: UITableView, message: String){
        let label = UILabel()
        label.text = message
        label.font = UIFont(name: "Poppins-Regular", size: 20)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.center = tableView.center
        tableView.backgroundView = label
    }
    
    func addNoDataView(tableView: UITableView, message: String, lottieName: String = "no_data_found_lottie"){
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.alignment = .center
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 10
        
//        let lottiView = LottieAnimationView(name: lottieName)
//        lottiView.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        lottiView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        lottiView.loopMode = .loop
//        lottiView.play()
        
        let label = UILabel()
        label.text = message
        label.font = UIFont(name: "Poppins-Regular", size: 20)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.center = tableView.center
        tableView.backgroundView = hStack
        
//        vStack.addArrangedSubview(lottiView)
        vStack.addArrangedSubview(label)
        hStack.addArrangedSubview(vStack)
    }
    
    func addNoDataView(collectionView: UICollectionView, message: String){
        let label = UILabel()
        label.text = message
        label.font = UIFont(name: "Poppins-Regular", size: 20)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.center = collectionView.center
        collectionView.backgroundView = label
    }
}

extension UITableView {
    func addNoDataView(message: String, lottieName: String = ""){
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        
//        let lottiView = LottieAnimationView(name: lottieName)
//        lottiView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
//        lottiView.loopMode = .loop
        
        
        let label = UILabel()
        label.text = message
        label.font = UIFont(name: "Poppins-Regular", size: 20)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.center = self.center
        self.backgroundView = label
        
      //  stack.addArrangedSubview(lottiView)
        stack.addArrangedSubview(label)
    }
}
