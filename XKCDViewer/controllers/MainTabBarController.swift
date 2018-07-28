import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        viewControllers = [
            generateNavigationController(for: ComicViewController(), title: "Comics", image: UIImage.init(named: "feels")!),
        ]
    }
    
    private func generateNavigationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
