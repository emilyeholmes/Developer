//
//  StatsVC.swift
//  Meet the Members
//
//  Created by Michael Lin on 1/18/21.
//

import UIKit

class StatsVC: UIViewController {
    
    // MARK: STEP 11: Going to StatsVC
    // Read the instructions in MainVC.swift
    
    var streak: Int?
    var lastThreeResults: [Bool]?
    
    init(streak: Int, lastThreeResults: [Bool]) {
        self.streak = streak
        self.lastThreeResults = lastThreeResults
        // Delegate rest of the initialization to super class
        // designated initializer.
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: >> Your Code Here <<
    
    // MARK: STEP 12: StatsVC UI
    // Action Items:
    // - Initialize the UI components, add subviews and constraints

    

    let streakLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let lastThreeResultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemRed
        config.imagePadding = 10
        button.configuration = config
        
        let image = UIImage(systemName: "x.circle.fill")
        button.setImage(image, for: .normal)
        
        return button
    }()
    
    @objc func dismissHandler(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    // MARK: >> Your Code Here <<
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: >> Your Code Here <<
        view.backgroundColor = .systemBlue
        
        dismissButton.addTarget(self, action: #selector(dismissHandler(_:)), for: .touchUpInside)
        
        streakLabel.text = "Longest Streak: " + String(streak!)
        lastThreeResultsLabel.text = "Previous Results: "
        for r in lastThreeResults! {
            if r {
                lastThreeResultsLabel.text = lastThreeResultsLabel.text! + "Correct! "
            } else {
                lastThreeResultsLabel.text = lastThreeResultsLabel.text! + "Incorrect! "
            }
        }

        view.addSubview(streakLabel)
        NSLayoutConstraint.activate([
            streakLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            streakLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
        
        view.addSubview(lastThreeResultsLabel)
        NSLayoutConstraint.activate([
            lastThreeResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastThreeResultsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250)
        ])
        
        view.addSubview(dismissButton)
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            dismissButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
    }
}
