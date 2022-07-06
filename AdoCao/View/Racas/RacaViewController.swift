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
        racasTableView.dataSource = self
        racasTableView.delegate = self
        pesquisarRacaSearchBar.delegate = self
        viewModel.delegate = self
        pesquisarRacaSearchBar.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        let processor = DownsamplingImageProcessor(size: cell.imageView!.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        
        guard let urlImagem = viewModel.obterURLImagem(raca: raca) else { return UITableViewCell() }
        cell.textLabel?.text = raca.nome
        
        cell.imageView?.kf.setImage(
            with: urlImagem,
            placeholder: UIImage(named: "iconDog"),
            options: [
                .processor(processor),
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25))
            ],
            progressBlock: { receivedSize, totalSize in
                // Progress updated
            },
            completionHandler: { result in
                // Done
            }
        )
        cell.imageView?.contentMode = .scaleAspectFill
        
//        cell.imageView?.loadFrom(URLAddress: raca.imagemURL)
//        tableView.estimatedRowHeight = 140
//        cell.imageView?.frame.size.width = 150
//        cell.imageView?.frame.size.height = 140
//        cell.imageView?.contentMode = .scaleAspectFit
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
