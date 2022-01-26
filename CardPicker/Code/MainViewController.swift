//
//  MainViewController.swift
//  CardPicker
//
//  Created by Nikita on 02.01.2022.
//

import UIKit

class MainViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [PickerViewController()]
    }
}
