//
//  DetalhesRacaViewController.swift
//  AdoCao
//
//  Created by Marcos Vinicius on 08/06/22.
//

import UIKit

class DetalhesRacaViewController: UIViewController {

    @IBOutlet weak var racaImageView: UIImageView!
    @IBOutlet weak var caracteristicasLable: UILabel!
    @IBOutlet weak var naturalDeLabel: UILabel!
    @IBOutlet weak var pesoLabel: UILabel!
    @IBOutlet weak var alturaLabel: UILabel!
    @IBOutlet weak var estimativaDeVidaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        racaImageView.layer.masksToBounds = true
        racaImageView.layer.cornerRadius = racaImageView.bounds.width / 2
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
