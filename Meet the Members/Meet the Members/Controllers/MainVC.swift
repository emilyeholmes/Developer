//
//  MainVC.swift
//  Meet the Members
//
//  Created by Michael Lin on 1/18/21.
//

import Foundation
import UIKit

class MainVC: UIViewController {
    
    // Create a property for our timer, we will initialize it in viewDidLoad
    var timer: Timer?
    var currTime: Int = 5
    var paused: Bool = false
    var currScore: Int = 0
    var longestStreak: Int = 0
    var currStreak: Int = 0
    var lastThree: [Bool]? = [false]
    var correct: String = ""
    
    // MARK: STEP 7: UI Customization
    // Action Items:
    // - Customize your imageView and buttons.
    
    let imageView: UIImageView = {
        let view = UIImageView()
        
        // MARK: >> Your Code Here <<
        //view.sizeToFit()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let buttons: [UIButton] = {
        return (0..<4).map { index in
            let button = UIButton()

            // Tag the button its index
            button.tag = index
            
            // MARK: >> Your Code Here <<
            var config = UIButton.Configuration.gray()
            button.configuration = config
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF", size: 12)
        return label
    }()
    
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "SF-Bold", size: 20)
//        label.textColor = .white
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    // MARK: STEP 10: Stats Button
    // Action Items:
    // - Follow the examples you've seen so far, create and
    // configure a UIButton for presenting the StatsVC. Only the
    // callback function `didTapStats(_:)` was written for you.
    
    // MARK: >> Your Code Here <<
    
    let statsButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Stats", for: UIControl.State.normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        config.imagePadding = 10
        button.configuration = config
        
        let image = UIImage(systemName: "chart.bar.fill")
        button.setImage(image, for: .normal)
        
        return button
        
    }()
    
    let pauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .gray
        config.imagePadding = 10
        button.configuration = config
        
        let image = UIImage(systemName: "pause.circle.fill")
        button.setImage(image, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        getNextQuestion()
        
        paused = false
        pauseButton.addTarget(self, action: #selector(tapPauseHandler(_:)), for: .touchUpInside)
        
        // MARK: STEP 6: Adding Subviews and Constraints
        // Action Items:
        // - Add imageViews and buttons to the root view.
        // - Create and activate the layout constraints.
        // - Run the App
        
        // Additional Information:
        // If you don't like the default presentation style,
        // you can change it to full screen too! However, in this
        // case, because user can no longer swipe down to dismiss
        // the sheet, you will have to find a way to manually to call
        // dismiss(animated: true, completion: nil) in order
        // to go back.
        //
        // modalPresentationStyle = .fullScreen
        
        // MARK: >> Your Code Here <<
        
        self.view.addSubview(statsButton)
        NSLayoutConstraint.activate([
            statsButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            statsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -200),
            statsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
        ])
        
        self.view.addSubview(pauseButton)
        NSLayoutConstraint.activate([
            pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
        ])
        
//        self.view.addSubview(nameLabel)
//        NSLayoutConstraint.activate([
//            nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
//        ])
        
        self.view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350)
        ])
        
        self.view.addSubview(buttons[0])
        NSLayoutConstraint.activate([
            buttons[0].leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            buttons[0].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            buttons[0].topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            buttons[0].bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250)
        ])
        
        self.view.addSubview(buttons[1])
        NSLayoutConstraint.activate([
            buttons[1].leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            buttons[1].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            buttons[1].topAnchor.constraint(equalTo: view.topAnchor, constant: 550),
            buttons[1].bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
        
        self.view.addSubview(buttons[2])
        NSLayoutConstraint.activate([
            buttons[2].leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            buttons[2].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            buttons[2].topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
            buttons[2].bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
        
        self.view.addSubview(buttons[3])
        NSLayoutConstraint.activate([
            buttons[3].leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            buttons[3].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            buttons[3].topAnchor.constraint(equalTo: view.topAnchor, constant: 650),
            buttons[3].bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        imageView.sizeToFit()
        
        // MARK: STEP 9: Bind Callbacks to the Buttons
        // Action Items:
        // - Bind the `didTapAnswer(_:)` function to the buttons.
        
        // MARK: >> Your Code Here <<
        for b in buttons {
            b.addTarget(self, action: #selector(tapAnswerHandler(_:)), for: .touchUpInside)
        }
        
        // MARK: STEP 10: Stats Button
        // See instructions above.
        
        // MARK: >> Your Code Here <<
        statsButton.addTarget(self, action: #selector(tapStatsHandler(_:)), for: .touchUpInside)

        self.view.addSubview(timerLabel)
        timerLabel.text = "Time: " + String(currTime)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 280),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
        ])
        
        startTimer()
        
    }
    
    // What's the difference between viewDidLoad() and
    // viewWillAppear()? What about viewDidAppear()?
    override func viewWillAppear(_ animated: Bool) {
        // MARK: STEP 13: Resume Game
        
        // MARK: >> Your Code Here <<
        paused = false
    }
    
    func getNextQuestion() {
        // MARK: STEP 5: Data Model
        // Action Items:
        // - Get a question instance from `QuestionProvider`
        // - Configure the imageView and buttons with information from
        //   the question instance
        
        // MARK: >> Your Code Here <<
        let qp = QuestionProvider()
        let question: QuestionProvider.Question? = qp.nextQuestion()
        imageView.image = question?.image
        var counter = 0
        for b in buttons {
            let thisOption:String? = question?.choices[counter]
            b.setTitle(thisOption, for: .normal)
            if thisOption == question?.answer {
                b.tag = 100
                correct = thisOption!
                b.setTitleColor(.green, for: .highlighted)
            } else {
                b.setTitleColor(.red, for: UIControl.State.highlighted)
            }
            b.setTitleColor(.systemGray, for: .normal)
            counter += 1
        }
        currTime = 5
        
    }
    
    // MARK: STEP 8: Buttons and Timer Callback
    // You don't have to
    // Action Items:
    // - Complete the callback function for the 4 buttons.
    // - Complete the callback function for the timer instance
    // - Call `startTimer()` where appropriate
    //
    // Additional Information:
    // Take some time to plan what should be in here.
    // The 4 buttons should share the same callback.
    //
    // Add instance properties and/or methods
    // to the class if necessary. You may need to come back
    // to this step later on.
    //
    // Hint:
    // - Checkout `UIControl.addAction(_:for:)`
    //      (`UIButton` subclasses `UIControl`)
    // - You can use `sender.tag` to identify which button is pressed.
    // - The timer will invoke the callback every one second.
    func startTimer() {
        // Create a timer that calls timerCallback() every one second
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    
    @objc func timerCallback() {
        // MARK: >> Your Code Here <<
        if paused == false {
            if currTime > 0 {
                timerLabel.textColor = .black
                currTime -= 1
            } else {
                timerLabel.textColor = .systemRed
                getNextQuestion()
            }
        }
        timerLabel.text = "Time: " + String(currTime)
    }
    
    @objc func tapPauseHandler(_ sender: UIButton) {
        if paused {
            let image = UIImage(systemName: "pause.circle.fill")
            pauseButton.setImage(image, for: .normal)
            paused = false
        } else {
            let image = UIImage(systemName: "play.circle.fill")
            pauseButton.setImage(image, for: .normal)
            paused = true
        }
    }
    
    @objc func tapAnswerHandler(_ sender: UIButton) {
        // MARK: >> Your Code Here <<
        if sender.tag == 100 {
            if currTime > 0 {
                currScore += 1
                currStreak += 1
            }
            if lastThree != nil {
                if lastThree!.count < 3 {
                    lastThree?.append(true)
                } else {
                    lastThree = [lastThree![1], lastThree![2], true]
                }
            }
            sender.setTitleColor(.green, for: .highlighted)
        } else {
            if currStreak > longestStreak {
                longestStreak = currStreak
            }
            currStreak = 0
            if lastThree != nil {
                if lastThree!.count < 3 {
                    lastThree?.append(false)
                } else {
                    lastThree = [lastThree![1], lastThree![2], false]
                }
            }
            sender.setTitleColor(.red, for: .highlighted)
        }
        sleep(2)
        getNextQuestion()
        
    }
    
    @objc func tapStatsHandler(_ action: UIAction) {
        
        let vc = StatsVC(streak: currScore, lastThreeResults: lastThree!)
        
        vc.modalPresentationStyle = .fullScreen

        // MARK: STEP 11: Going to StatsVC
        // When we are navigating between VCs (e.g MainVC -> StatsVC),
        // we often need a mechanism for transferring data
        // between view controllers. There are many ways to achieve
        // this (initializer, delegate, notification center,
        // combined, etc.). We will start with the easiest one today,
        // which is custom initializer.
        //
        // Action Items:
        // - Pause the game when stats button is tapped i.e. stop the timer
        // - Read the example in StatsVC.swift, and replace it with
        //   your custom init for `StatsVC`
        // - Update the call site here on line 139
        
        paused = true
        
        present(vc, animated: true, completion: nil)
        
    }
}
