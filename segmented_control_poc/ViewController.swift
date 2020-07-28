//
//  ViewController.swift
//  segmented_control_poc
//
//  Created by tomoyaitagaki on 2020/07/27.
//  Copyright © 2020 eversense. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let idList = ["FirstViewController", "SecondViewController"]

    var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController] = []

    private lazy var updateSwitch: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["First", "Second"])
        //        sc.widthForSegment(at: 128)  //sc.anchor(width: 128, height: 32)
        sc.selectedSegmentIndex = 0
        sc.tintColor = .cyan
        sc.backgroundColor = .lightGray
        sc.addTarget(self, action: #selector(handleSegmentedControlSwitch(_:)), for: .valueChanged)
        return sc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let segmented = self.updateSwitch
        segmented.addTarget(self, action: #selector(handleSegmentedControlSwitch(_:)), for: .valueChanged)
        navigationItem.titleView = segmented

        for id in idList {
            //            let sb = UIStoryboard(name: id, bundle: nil)
            if id == "FirstViewController" {
                let sb = UIStoryboard(name: "FirstViewController", bundle: nil)
                let vc = sb.instantiateInitialViewController() as! FirstViewController
                viewControllers.append(vc)
            } else {
                let sb = UIStoryboard(name: "SecondViewController", bundle: nil)
                let vc = sb.instantiateInitialViewController() as! SecondViewController
                viewControllers.append(vc)
            }
        }

        pageViewController = (children[0] as! UIPageViewController)
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        let index = idList.firstIndex(of: viewController.restorationIdentifier!)!
        updateSwitch.selectedSegmentIndex = index

        if (index > 0) {
            updateSwitch.selectedSegmentIndex = 0
            let sb = UIStoryboard(name: "FirstViewController", bundle: nil)
            return sb.instantiateInitialViewController() as! FirstViewController
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = idList.firstIndex(of: viewController.restorationIdentifier!)!
        updateSwitch.selectedSegmentIndex = index

        if (index < idList.count - 1) {
            let sb = UIStoryboard(name: "SecondViewController", bundle: nil)
            return sb.instantiateInitialViewController() as! SecondViewController
        }
        return nil
    }

    @objc func handleSegmentedControlSwitch(_ segmentedControl: UISegmentedControl) {
        switch(updateSwitch.selectedSegmentIndex) {
        case 0:
            print("0")
            pageViewController.setViewControllers([viewControllers[0]], direction: .reverse, animated: true, completion: nil)
            break
        case 1:
            print("1")
            pageViewController.setViewControllers([viewControllers[1]], direction: .forward, animated: true, completion: nil)
            break
        default:
            return
        }
    }
}
