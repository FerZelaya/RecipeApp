//
//  HomeViewController.swift
//  RecipeApp
//
//  Created by Fernando Zelaya on 5/13/20.
//  Copyright © 2020 Fernando Zelaya. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var homeCV: UICollectionView!
    
    
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
        
        getRandomRecipe()
       
        
    }
    
    
    

    //MARK: - CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomRecipeArray.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCV.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as! HomeCustomCollectionViewCell
        
        cell.titleLabel.text = randomRecipeArray[indexPath.row].recipes[indexPath.row].title
        cell.timeLabel.text = String(randomRecipeArray[indexPath.row].recipes[indexPath.row].readyInMinutes)
        
        let imgURL: URL? = URL(string: randomRecipeArray[indexPath.row].recipes[indexPath.row].image)
        
        if let url = imgURL {
            cell.Image.sd_setImage(with: url)
        }
        
        
        
        return cell
    }
    
    
    
    
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
                
                self?.homeCV.reloadData()
            }
        }.resume()
        
        
    }
    
    
    
}




//MARK: - Extensions



