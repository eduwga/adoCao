//
//  CadastrarAmigoViewController.swift
//  AdoCao
//
//  Created by Marcos Vinicius on 06/06/22.
//

import UIKit

class CadastrarAmigoViewController: UIViewController {

    @IBOutlet weak var perfilImageView: UIImageView!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var idadeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        perfilImageView.layer.masksToBounds = true
        perfilImageView.layer.cornerRadius = perfilImageView.bounds.width
    }
    

    @IBAction func cadastrarButton(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
