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
    
    


}


extension HomeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("--------->count \(homeBrain.getRecipeMap().count)")
        return homeBrain.getRecipeMapSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = home_TV_table.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! RecipeCell
        
        let index = Array(homeBrain.getRecipeMap().keys)[indexPath.row]
        let recipe = homeBrain.getRecipeMap()[index]!
        // Create a reference to the file you want to download
        print("--------->TABLE VIEW")
        cell.recipe_IMG_image.imageFrom(url: recipe.imageURL!)
        cell.recipe_LBL_name.text = "\(recipe.name!)"
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        home_TV_table.reloadData()
    }
    
}
// display image by url
//extension UIImageView{
//    func imageFrom(url:URL){
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url){
//                if let image = UIImage(data:data){
//                    DispatchQueue.main.async{
//                        self?.image = image
//
//                    }
//                }
//            }
//        }
//    }
//}
