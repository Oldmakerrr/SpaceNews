//
//  Routable.swift
//  space
//
//  Created by Vladimir Berezin on 8.10.23..
//

import UIKit

protocol Routable {
    func showController(_ controller: UIViewController, animated: Bool)
    func presentController(_ controller: UIViewController, animated: Bool)
}

extension UIViewController: Routable {

    func showController(_ controller: UIViewController, animated: Bool) {
        if let navigationController = navigationController {
            navigationController.pushViewController(controller, animated: animated)
        } else {
            present(controller, animated: animated)
        }
    }

    func presentController(_ controller: UIViewController, animated: Bool) {
        present(controller, animated: animated)
    }

}
