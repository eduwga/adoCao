//
//  SuporteViewController.swift
//  AdoCao
//
//  Created by Murilo Ribeiro de Oliveira on 09/06/22.
//

import UIKit

class SuporteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func retornaButtonNavigation(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
