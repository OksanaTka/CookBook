
import UIKit

class MyRecipeViewController: UIViewController {
    
    @IBOutlet weak var my_LBL_norecipe: UILabel!
    @IBOutlet weak var my_TV_table: UITableView!
    var homeBrain = HomeBrain()
    var myRecipeBrain = MyRecipeBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check if user has recipes
        if myRecipeBrain.initUserRecipeMap() {
            my_LBL_norecipe.isHidden = true

        }else{
            my_LBL_norecipe.isHidden = false
        }
        //init table view
        my_TV_table.dataSource = self
        my_TV_table.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }

}


extension MyRecipeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRecipeBrain.getUserRecipeMapSize()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = my_TV_table.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! RecipeCell
        my_LBL_norecipe.isHidden = true
        let recipeIndex = Array(myRecipeBrain.getUserRecipeMap().keys)[indexPath.row]
        let recipe = myRecipeBrain.getUserRecipeMap()[recipeIndex]!
    
        
        // init cell
        cell.recipe_IMG_image.imageFrom(url: recipe.imageURL!)
        cell.recipe_LBL_name.text = "\(recipe.name!)"
        cell.recipe_LBL_likes.text = "\(recipe.numberOfLikes ?? 0)"
        cell.recipe_BTN_detailes.isHidden = true
        
        if(homeBrain.recipeExistInLikedList(recipeId: recipeIndex)){
            cell.recipe_IMG_like.image = UIImage(named: "Like")
        }
        else{
            cell.recipe_IMG_like.image = UIImage(named: "Unlike")
        }
                
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        my_TV_table.reloadData()
    }
}
