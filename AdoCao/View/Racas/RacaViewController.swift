//
//  RacaViewController.swift
//  AdoCao
//
//  Created by André N. dos Santos on 07/06/22.
//

import UIKit
import Kingfisher

class RacaViewController: UIViewController {

    @IBOutlet weak var racasTableView: UITableView!
    @IBOutlet weak var pesquisarRacaSearchBar: UISearchBar!
    
    let viewModel = RacasViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 1.00)
        racasTableView.backgroundColor = UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 1.00)
        racasTableView.separatorColor = .systemPurple
        racasTableView.dataSource = self
        racasTableView.delegate = self
        pesquisarRacaSearchBar.delegate = self
        pesquisarRacaSearchBar.barTintColor = UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 0.5)
        viewModel.delegate = self
        racasTableView.keyboardDismissMode = .onDrag // or .interactive
        pesquisarRacaSearchBar.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
        cell.backgroundColor = UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 1.00)
        cell.textLabel?.textColor = .systemPurple
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        cell.imageView?.layer.masksToBounds = true
        cell.imageView?.layer.cornerRadius = 10
        let raca = viewModel.obterRaca(posicao: indexPath.row)
        
        guard let urlImagem = viewModel.obterURLImagem(raca: raca) else { return UITableViewCell() }
        cell.textLabel?.text = raca.nome
        
        let imagem = viewModel.buscarImagem(posicao: raca.id)
        if let imagem = imagem {
            cell.imageView?.image = imagem
        }
        else {
            cell.imageView?.kf.setImage(
                with: urlImagem,
                placeholder: UIImage(named: "iconDog"),
                options: [
                    .loadDiskFileSynchronously,
                    .cacheOriginalImage,
                    .transition(.fade(0.25))
                ],
                progressBlock: { receivedSize, totalSize in
                    // Progress updated
                },
                completionHandler: { result in
                    switch result {
                    case .success(let imagemResult):
                        self.viewModel.carregarImagensRacas(posicao: raca.id, image: imagemResult.image)
                    case .failure(_):
                        break
                    }
                }
            )
        }
        cell.imageView?.contentMode = .scaleAspectFill
        
        return cell
    }
}

extension RacaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detalhesRacaSegue", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension RacaViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.pesquisarRacaPorNome(nomePesquisado: searchText)
    }
}

extension RacaViewController: RacasViewModelDelegate {
    func listaDeRacasFoiModificada(racas: [Raca]) {

        for raca in racas {
            _ = UIImageView().kf.setImage(with: URL(string: raca.imagemURL),options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25))
            ])
        }
        racasTableView.reloadData()
    }
    
    func listaDeRacasFoiModificada() {
        racasTableView.reloadData()
    }
    
    
}
