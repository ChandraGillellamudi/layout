//  Copyright © 2017 Schibsted. All rights reserved.

import UIKit
import Layout

class ExamplesViewController: LayoutViewController, UITabBarControllerDelegate {

    private var selectedTab = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        loadLayout(
            named: "Examples.xml",
            constants: [
                // Used in boxes example
                "colors": [
                    "red": UIColor(hexString: "#f66"),
                    "orange": UIColor(hexString: "#fa7"),
                    "blue": UIColor(hexString: "#09f"),
                    "green": UIColor(hexString: "#0f9"),
                    "pink": UIColor(hexString: "#fcc"),
                ],
                // Used in text example
                "attributedString": NSAttributedString(
                    string: "attributed string",
                    attributes: [NSForegroundColorAttributeName: UIColor.red]
                ),
            ]
        )
    }

    override var layoutNode: LayoutNode? {
        didSet {
            guard let tabBarController = layoutNode?.viewController as? UITabBarController else {
                return
            }
            tabBarController.selectedIndex = selectedTab
            tabBarController.delegate = self
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let index = tabBarController.viewControllers?.index(of: viewController) else {
            return
        }
        selectedTab = index
    }
}
