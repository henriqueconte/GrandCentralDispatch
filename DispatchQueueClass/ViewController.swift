//
//  ViewController.swift
//  DispatchQueueClass
//
//  Created by Henrique Figueiredo Conte on 27/08/19.
//  Copyright © 2019 Henrique Figueiredo Conte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroTextField: UITextField!
    
    //let searchNetworking = SearchNetworking()
    let heroProvider = HeroProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroTextField.delegate = self
        heroProvider.provideHeroInformation(heroName: "batman", completion: { [weak self] (imageData, heroName, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self!.heroImageView.image = UIImage(data: imageData ?? Data())
                    self!.heroNameLabel.text = heroName ?? ""
                }
            
            }
        })
        
    }

}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let searchedHero = textField.text
        textField.endEditing(true)
        
        heroProvider.provideHeroInformation(heroName: searchedHero, completion: { [weak self] (imageData, heroName, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self!.heroImageView.image = UIImage(data: imageData ?? Data())
                    self!.heroNameLabel.text = heroName ?? ""
                }
                
            }
        })
        
        
        
        return true
    }
}

