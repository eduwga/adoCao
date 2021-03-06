//
//  ListarAmigosParaAdocaoViewController.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 31/05/22.
//

import UIKit

class ListarAmigosParaAdocaoViewController: UIViewController {
    
    
    let viewModel = ListarAmigosViewModel()
    
    var dogs: [ListarAmigosClient] = []
    
    var service = ListarAmigosService()

    @IBOutlet weak var listarAmigosTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        listarAmigosTableView.dataSource = self
        listarAmigosTableView.delegate = self
    }
}

extension ListarAmigosParaAdocaoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.listaDeCaes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "caoCell") as? ListarAmigosCustomCell else { return UITableViewCell()}
        
        cell.configura(cao: service.listaDeCaesQueOServidorConhece()[indexPath.row])
                return cell
    }
}

extension ListarAmigosParaAdocaoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
