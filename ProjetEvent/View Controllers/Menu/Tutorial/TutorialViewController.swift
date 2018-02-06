//
//  TutorialViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 30/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class TutorialViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {


    lazy var orderedViewControllers: [UIViewController] = {
        return[self.newVC(viewController: "pageOne"),
               self.newVC(viewController: "pageTwo"),
               self.newVC(viewController: "pageThree")
        ]
    }()

    var pageControl = UIPageControl()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self

       if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
       self.delegate = self
        configurePageControl()
    }

    func configurePageControl(){
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.red
        self.view.addSubview(pageControl)
    }

    func newVC(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Tutorial", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }



    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1
        _ = orderedViewControllers.count

        guard orderedViewControllers.count != previousIndex else {
            return orderedViewControllers.first
           // return nil
        }

        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController ) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex >= 0 else {
            return orderedViewControllers.last
           // return nil
        }

        guard orderedViewControllers.count > nextIndex else {
            return nil
        }

        return orderedViewControllers[nextIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


