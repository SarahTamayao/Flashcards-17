//
//  ViewController.swift
//  Flashcards
//
//  Created by Rachel Pham on 3/4/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden == true){
            frontLabel.isHidden = false
        }
        else if (frontLabel.isHidden == false){
            frontLabel.isHidden = true
        }
        }
    }
    

