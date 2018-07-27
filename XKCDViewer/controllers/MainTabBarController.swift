import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        tabBar.tintColor = UIColor.background
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        viewControllers = [
            generateNavigationController(for: ComicViewController(), title: "Comics", image: "feels"),
            generateNavigationController(for: ComicViewController(), title: "Comics", image: "feels")
        ]
    }
    
    private func generateNavigationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage.init(named: image)
        return navController
    }
}
