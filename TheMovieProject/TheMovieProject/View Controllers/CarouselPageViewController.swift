import Foundation
import UIKit

class CarouselPageViewController: UIPageViewController {
    fileprivate var items: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        decoratePageControl()
        populateItems()

        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    fileprivate func decoratePageControl() {
        let pageCtrl = UIPageControl.appearance(whenContainedInInstancesOf: [CarouselPageViewController.self])
        pageCtrl.currentPageIndicatorTintColor = UIColor(red: 2.0 / 255.0,
                                                         green: 148.0 / 255.0,
                                                         blue: 165.0 / 255.0,
                                                         alpha: 0.4)
        pageCtrl.pageIndicatorTintColor = .white
        pageCtrl.backgroundColor = UIColor.clear
        pageCtrl.translatesAutoresizingMaskIntoConstraints = false
    }

    fileprivate func populateItems() {
        let images: [UIImage] = [
            UIImage(named: "background1")!,
            UIImage(named: "background2")!,
            UIImage(named: "background3")!
        ]
        let backgroundColor: [UIColor] = [.blue, .red, .green]
        for (index, tmp) in images.enumerated() {
            let color = createCarouselItemControler(with: tmp, with: backgroundColor[index])
            items.append(color)
        }
    }
    fileprivate func createCarouselItemControler(with imageTitle: UIImage?, with color: UIColor?) -> UIViewController {
        let crsl = UIViewController()
        crsl.view = CarouselItem(imageName: imageTitle, background: color)
        return crsl
    }
}

// MARK: - DataSource

extension CarouselPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return items.last
        }

        guard items.count > previousIndex else {
            return nil
        }
        return items[previousIndex]
    }
    func pageViewController(_: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            return items.first
        }

        guard items.count > nextIndex else {
            return nil
        }

        return items[nextIndex]
    }

    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }

    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                return 0
        }
        return firstViewControllerIndex
    }
}
