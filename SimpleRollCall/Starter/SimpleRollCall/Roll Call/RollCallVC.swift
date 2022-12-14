//
//  RollCallVC.swift
//  CalHacksDemo
//
//  Created by Michael Lin on 8/26/20.
//  Copyright © 2020 Michael Lin. All rights reserved.
//

import UIKit

class RollCallVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()


        let view = UIView(frame: .zero)
        view.backgroundColor = .systemRed
        self.view.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 88),
            view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        ])
    }
//    private func showNextNameOrResult() {
//        if let name = Roster.main.getNextName() {
//            setUserInteractionEnabled(to: false)
//            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
//                self.nameLabel.alpha = 0
//            }, completion: { _ in
//                self.nameLabel.text = name
//                self.setUserInteractionEnabled(to: true)
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.nameLabel.alpha = 1
//                })
//            })
//        } else {
//            performSegue(withIdentifier: "toResults", sender: nil)
//        }
//    }
//
//    private func setUserInteractionEnabled(to value: Bool) {
//        presentButton.isUserInteractionEnabled = value
//        absentButton.isUserInteractionEnabled = value
//    }
}
