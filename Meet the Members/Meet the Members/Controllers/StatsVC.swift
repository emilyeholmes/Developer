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
    
    var score: Int?
    var missed: Int?
    
    init(score: Int, missed: Int) {
        self.score = score
        self.missed = missed
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

    

    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let missedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF", size: 24)
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
        
        scoreLabel.text = "Current Score: " + String(score!)
        missedLabel.text = "Missed Answers: " + String(missed!)
        
        view.addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
        
        view.addSubview(missedLabel)
        NSLayoutConstraint.activate([
            missedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            missedLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 230)
        ])
        
        view.addSubview(dismissButton)
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            dismissButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
    }
}
