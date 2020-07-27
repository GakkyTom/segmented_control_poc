//
//  ViewController.swift
//  segmented_control_poc
//
//  Created by tomoyaitagaki on 2020/07/27.
//  Copyright © 2020 eversense. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentedContol: UISegmentedControl!
    @IBOutlet weak var colorLabel: UILabel!

    private lazy var updateSwitch: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Sign In", "Sign Out"])
//        sc.widthForSegment(at: 128)  //sc.anchor(width: 128, height: 32)
        sc.selectedSegmentIndex = 0
        sc.tintColor = .cyan
        sc.backgroundColor = .darkGray
        sc.addTarget(self, action: #selector(handleSegmentedControlSwitch(_:)), for: .valueChanged)
        return sc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let segmented = self.updateSwitch
        segmented.addTarget(self, action: #selector(handleSegmentedControlSwitch(_:)), for: .valueChanged)
        navigationItem.titleView = segmented

        segmentedContol.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], for: .normal)
    }

    @objc func handleSegmentedControlSwitch(_ segmentedControl: UISegmentedControl) {
        switch(segmentedControl.selectedSegmentIndex) {
            case 0:
                print("Sign In")
            break
            case 1:
                print("Sign Out")
            break
            default:
            break
        }
    }

    @IBAction func segmentedControlToggled(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            colorLabel.text = "Yellow"
            colorLabel.textColor = UIColor.yellow
            let sb = UIStoryboard(name: "YellowViewController", bundle: nil)
            let vc = sb.instantiateInitialViewController() as! YellowViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            colorLabel.text = "Green"
            colorLabel.textColor = UIColor.green
        default:
            colorLabel.text = "Color Label"
            colorLabel.textColor = UIColor.black
        }


    }

}
