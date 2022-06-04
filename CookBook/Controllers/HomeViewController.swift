//
//  HomeViewController.swift
//  CookBook
//
//  Created by user216397 on 5/26/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class HomeViewController: UIViewController {

    

    @IBOutlet weak var home_TV_table: UITableView!
    
    let db = Firestore.firestore()
    var storage = Storage.storage()
    var homeBrain = HomeBrain()
    var recipeData = RecipeData.recipeData
    let user = User.user
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("--------->TABLE VIEW???? in func")
        home_TV_table.dataSource = self
        home_TV_table.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openRecipe"{
            let recipeDetailsVC = segue.destination as! RecipeDetailsViewController
            recipeDetailsVC.index = homeBrain.getCurrentRecipeIndex()
            recipeDetailsVC.delegate = self
        }
    }

}



extension HomeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("--------->count \(homeBrain.getRecipeMap().count)")
        return homeBrain.getRecipeMapSize()
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = home_TV_table.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! RecipeCell
        
        let recipeIndex = Array(homeBrain.getRecipeMap().keys)[indexPath.row]
        let recipe = homeBrain.getRecipeMap()[recipeIndex]!
        
        cell.recipe = recipe
        cell.index = recipeIndex
        
        // init cell
        cell.recipe_IMG_image.imageFrom(url: recipe.imageURL!)
        cell.recipe_LBL_name.text = "\(recipe.name!)"
        cell.recipe_LBL_likes.text = "\(recipe.numberOfLikes ?? 0)"
        cell.recipe_BTN_detailes.tag = indexPath.row
        
        if(!user.getLikedRecipeList().isEmpty && user.getLikedRecipeList().contains(recipeIndex)){
            print("---> true")
            cell.recipe_IMG_like.image = UIImage(named: "Like")
        }
        else{
            print("---> false")
            cell.recipe_IMG_like.image = UIImage(named: "Unlike")
        }
        
        cell.delegate = self
        
        return cell
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        home_TV_table.reloadData()
    }
    
}

extension HomeViewController: MyTableViewCellDelegate{
    
    func didTapButton(index: Int) {
        homeBrain.setCurrentRecipeIndex(index: index)
        self.performSegue(withIdentifier: "openRecipe", sender: self)
    }
}
extension HomeViewController: TableViewCellDelegate{
    func updateTable() {
        home_TV_table.reloadData()
        print("4545454545454545454545454545454545454545454545454545454")
    }
    
    
}
