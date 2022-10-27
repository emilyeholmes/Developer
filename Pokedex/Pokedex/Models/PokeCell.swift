//
//  PokeCell.swift
//  Pokedex
//
//  Created by Emily Holmes on 10/25/22.
//

import Foundation
import UIKit

class PokeCell: UICollectionViewCell {
    

    
    let iv: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let myName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        label.textColor = .white
        return label
    }()
    
    let myID: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
        label.textColor = .white
        return label
    }()
    
    var data: Pokemon? {
        didSet {
            guard let data else { return }
            
            guard let url = data.imageUrl else { return }
            
            DispatchQueue.global(priority: .background).async {
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        guard let loadedImage = UIImage(data: imageData) else {
                            return
                        }
                        
                        self.iv.image = loadedImage
                    }
                }
            }
            
            self.myName.text = data.name
            self.myID.text = String(data.id)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(iv)
        contentView.addSubview(myName)
        contentView.addSubview(myID)
        
        NSLayoutConstraint.activate([
            iv.topAnchor.constraint(equalTo: contentView.topAnchor),
            iv.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            iv.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iv.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myName.topAnchor.constraint(equalTo: iv.bottomAnchor),
            myName.centerXAnchor.constraint(equalTo: iv.centerXAnchor),
            myID.topAnchor.constraint(equalTo: myName.bottomAnchor, constant: 5),
            myID.centerXAnchor.constraint(equalTo: myName.centerXAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
