//
//  API.swift
//  BookStore
//
//  Created by Sanjay Mali on 30/04/21.
//

import Foundation
import UIKit
class API{
    let endPoint = "http://skunkworks.ignitesol.com:8000/books/?search="
}
class showAlert{
    static func showAlert(ref : UIViewController,alertmessage : String){
        let alert = UIAlertController(title: "", message: alertmessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {
            ref.present(alert, animated: true, completion: nil)
        }
    }
    static func showAlerActionSheet(indexPathhtml:String?, indexPathPlainText:String?,ref:UIViewController){
        let alertController = UIAlertController(title: "Hey BookStore", message: "What do you want to do read?", preferredStyle: .actionSheet)
        let defaultAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let defaultActionHtml = UIAlertAction(title: "HTML", style: .default, handler:{_ in
            if let url = URL(string:indexPathhtml ?? "") {
                UIApplication.shared.open(url)
            }else{
                DispatchQueue.main.async {
                    ref.present(alertController, animated: true, completion: nil)
                }
            }
        })
        let defaultActionPlainText = UIAlertAction(title: "PlainText", style: .default, handler:{_ in
            if let url = URL(string:indexPathPlainText ?? "") {
                UIApplication.shared.open(url)
            }else{
                ref.present(alertController, animated: true, completion: nil)
            }
        })
        alertController.addAction(defaultActionHtml)
        alertController.addAction(defaultActionPlainText)
        alertController.addAction(defaultAction)
        ref.present(alertController, animated: true, completion: nil)
    }
}
