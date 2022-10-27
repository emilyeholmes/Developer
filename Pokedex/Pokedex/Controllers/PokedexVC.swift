//
//  ViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2/18/21.
//
// MARK: Emily's notes
// I've added every Pokemon to a collection view, enabled tapping on a Pokemon to get more info
// - Not sure where to instantiate navigation controller, in this class? Also just not sure about presenting vc's that way (correct commands/methods and where to call them)
// - I think I have the logic for the search bar but not sure how to actually add the search bar itself to the view (but I have some logic for presenting filtered pokemon: if the search bar is empty, show all the pokemon in the collection view, if the search bar is not empty show only pokemon that match the filtering)
// - I also know I should be fetching the images differently so it's less laggy I just can't remember the exact syntax
// - Also the UI is bad :( how to make the cells more centered and less spaced out? and also not sure why spacing btwn image and label is so weird

import UIKit

class PokedexVC: UIViewController {
    
    //let navController = UINavigationController(rootViewController: PokedexVC())
    
    let pokemons = PokemonGenerator.shared.getPokemonArray()
    
    var filteredPokemon: [Pokemon] = PokemonGenerator.shared.getPokemonArray()
    
    let cv: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            return layout
        }())
        cv.backgroundColor = #colorLiteral(red: 0.2238987684, green: 0.3496474028, blue: 0.6313779354, alpha: 1)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PokeCell.self, forCellWithReuseIdentifier: "PokeCell")
        return cv
    }()

    let searchController1: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Search Pokemon"
        return sc
    }()
    
    var isSearchBarEmpty: Bool {
      return searchController1.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        cv.dataSource = self
        cv.delegate = self
        
        let pokeTitle: UIImageView = {
            let iv = UIImageView()
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.contentMode = .scaleAspectFill
            
            let myurl = URL(string: "https://fontmeme.com/images/Pokemon-Logo.jpg")
            
            let session = URLSession.shared.dataTask(with: URLRequest(url: myurl!)) {
                responseData, response, error in
                if let error {
                    print(error.localizedDescription)
                    return
                }
                
                DispatchQueue.main.async {
                    iv.image = UIImage(data: responseData!)
                }
            }
            
            session.resume()
            
//            DispatchQueue.main.async {
//                if let imageData = try? Data(contentsOf: myurl!) {
//                    if let loadedImage = UIImage(data: imageData) {
//                        iv.image = loadedImage
//                    }
//                }
//            }
            return iv
        }()
        
        func configureSearchbar(){
                let searchController = UISearchController(searchResultsController: nil)
                searchController.searchBar.placeholder = "Search"
                searchController.searchResultsUpdater = self
                searchController.obscuresBackgroundDuringPresentation = false
                navigationItem.searchController = searchController
//                navigationItem.title = "Pokemon" //Navigation Title
                self.definesPresentationContext = true
            }
        
        configureSearchbar()
        self.view.addSubview(pokeTitle)
        self.view.addSubview(cv)
        
        
        NSLayoutConstraint.activate([
            pokeTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 210),
            pokeTitle.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 211),
            pokeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pokeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            cv.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 280),
            cv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            cv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            cv.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if searchText == "" {
            filteredPokemon = pokemons
        } else {
            filteredPokemon = []
            for pokemon in pokemons {
                if pokemon.name.lowercased().contains(searchText.lowercased()) {
                    filteredPokemon.append(pokemon)
                }
                else {
                    for type in pokemon.types {
                        if type.rawValue.lowercased().contains(searchText.lowercased()) {
                            filteredPokemon.append(pokemon)
                        }
                    }
                }
            }
        }
      cv.reloadData()
    }
}

extension PokedexVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as! PokeCell
        cell.data = self.filteredPokemon[indexPath.item]
        return cell
    }
}

extension PokedexVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.item]
        
        let focusVC = PokemonFocusVC()
        focusVC.data = pokemon
        self.navigationController?.pushViewController(focusVC, animated: true)
        //present(focusVC, animated: true)
    }
}

extension PokedexVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
           return CGSize(width: 150.0, height: 200.0)
        }
    
}

extension PokedexVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    
}



