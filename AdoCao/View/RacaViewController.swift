//
//  RacaViewController.swift
//  AdoCao
//
//  Created by André N. dos Santos on 07/06/22.
//

import UIKit

class RacaViewController: UIViewController {

    @IBOutlet weak var racasTableView: UITableView!
    @IBOutlet weak var pesquisarRacaSearchBar: UISearchBar!
    
    let viewModel = RacasViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        racasTableView.dataSource = self
        racasTableView.delegate = self
        pesquisarRacaSearchBar.delegate = self
        viewModel.delegate = self
        pesquisarRacaSearchBar.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let telaDetalhes = segue.destination as? DetalhesRacaViewController else { return }
        let detalhesRacaViewModel = viewModel.selecionouCelula(posicao: sender)
        telaDetalhes.configInicial(vm: detalhesRacaViewModel)
    }

}
extension RacaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.obterTotalDeRacas()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let raca = viewModel.obterRaca(posicao: indexPath.row)
        cell.textLabel?.text = raca.nome
        cell.imageView?.loadFrom(URLAddress: raca.imagemURL)
        cell.imageView?.bounds.size.width = 150
        cell.imageView?.bounds.size.height = 140
//        cell.imageView?.frame.size.width = 150
//        cell.imageView?.frame.size.height = 140
        return cell
    }
}

extension RacaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detalhesRacaSegue", sender: indexPath.row)
    }
}

extension RacaViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.pesquisarRacaPorNome(nomePesquisado: searchText)
    }
    
    
}

extension RacaViewController: RacasViewModelDelegate {
    func listaDeRacasFoiModificada() {
        racasTableView.reloadData()
    }
    
    
}
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
