//
//  BaseViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 25.12.2024.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func showAlertActionSheet(message: String) {
        let alert = UIAlertController(title: "Внимание!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
            UIAlertAction in
            print("Ok")
        }
        /*let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            print("Cancel Pressed")
        }*/
        alert.addAction(okAction)
        //alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }

}
