//
//  PokemonFocusVC.swift
//  Pokedex
//
//  Created by Emily Holmes on 10/26/22.
//

import Foundation
import UIKit

class PokemonFocusVC: UIViewController {
    
    
    let iv: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let myName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        return label
    }()
    
    let myID: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16.0)
        return label
    }()
    
    let myHealth: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16.0)
        return label
    }()
    
    let myAttack: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16.0)
        return label
    }()
    
    let myDefense: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16.0)
        return label
    }()
    
    var data: Pokemon? {
        didSet {
            guard let data else { return }
            
            guard let url = data.imageUrl else { return }
            
            DispatchQueue.main.async {
                if let imageData = try? Data(contentsOf: url) {
                    if let loadedImage = UIImage(data: imageData) {
                        self.iv.image = loadedImage
                    }
                }
            }
            self.myName.text = data.name
            self.myID.text = "ID: " + String(data.id)
            self.myAttack.text = "Attack: " + String(data.attack)
            self.myHealth.text = "Health: " + String(data.health)
            self.myDefense.text = "Defense: " + String(data.defense)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(iv)
        view.addSubview(myName)
        view.addSubview(myID)
        view.addSubview(myHealth)
        view.addSubview(myAttack)
        view.addSubview(myDefense)
        
        NSLayoutConstraint.activate([
            iv.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            iv.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
            iv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            iv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            myName.topAnchor.constraint(equalTo: iv.bottomAnchor, constant: 5),
            myName.centerXAnchor.constraint(equalTo: iv.centerXAnchor),
            myID.topAnchor.constraint(equalTo: myName.bottomAnchor, constant: 5),
            myID.centerXAnchor.constraint(equalTo: myName.centerXAnchor),
            myHealth.topAnchor.constraint(equalTo: myID.bottomAnchor, constant: 5),
            myHealth.centerXAnchor.constraint(equalTo: myID.centerXAnchor),
            myAttack.topAnchor.constraint(equalTo: myHealth.bottomAnchor, constant: 5),
            myAttack.centerXAnchor.constraint(equalTo: myHealth.centerXAnchor),
            myDefense.topAnchor.constraint(equalTo: myAttack.bottomAnchor, constant: 5),
            myDefense.centerXAnchor.constraint(equalTo: myAttack.centerXAnchor)
        ])
        
    }
}
