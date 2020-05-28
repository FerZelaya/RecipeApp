//
//  HomeViewController.swift
//  RecipeApp
//
//  Created by Fernando Zelaya on 5/13/20.
//  Copyright © 2020 Fernando Zelaya. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var randomRecipeCollectionView: UICollectionView!
    
    private var randomRecipeArray = [RandomRecipe]()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    
    
    
    //MARK: - CollectionView DataSource
  
    
    
    
    
    //MARK: - Networking
    
    func getRandomRecipe() {
        guard let url =	URL(string: "https://api.spoonacular.com/recipes/random?apiKey=1946d8a5bfe945e3a2ae213440081fde&number=1") else {
            fatalError("Error converting url")
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                guard let recipe = try? JSONDecoder().decode(RandomRecipe.self, from: data) else {
                    fatalError("Error decoding \(error!)")
                }
                self?.randomRecipeArray.append(recipe)
            }
           
            
            DispatchQueue.main.async {
                
                self?.randomRecipeCollectionView.reloadData()
            }
        }.resume()
        
        
    }
    
    
    
}




//MARK: - Extensions

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 290)
    }
}

