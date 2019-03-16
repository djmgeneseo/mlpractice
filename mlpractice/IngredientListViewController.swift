//
//  IngredientListViewController.swift
//  mlpractice
//
//  Created by David Nyman on 9/7/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class IngredientListViewController: UIViewController {

    @IBOutlet weak var ingredientView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientView.text = ViewController.newIngredient.list
    }
    


    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
