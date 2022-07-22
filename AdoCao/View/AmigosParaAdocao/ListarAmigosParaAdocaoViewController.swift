//
//  ListarAmigosParaAdocaoViewController.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 31/05/22.
//

import UIKit

class ListarAmigosParaAdocaoViewController: UIViewController {

    @IBOutlet weak var listarAmigosTableView: UITableView!
    @IBOutlet weak var listarAmigosSegmentedControl: UISegmentedControl!
    @IBOutlet weak var listarAmigosActivityIndicator: UIActivityIndicatorView!
    
    let viewModel = ListarAmigosViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        iniciaActivityIndicator(activityIndicatorView: listarAmigosActivityIndicator)
        navigationItem.hidesBackButton = true
        listarAmigosTableView.dataSource = self
        listarAmigosTableView.delegate = self
        viewModel.delegate = self

    }
    
    @IBAction func segmentedButtonAction(_ sender: Any) {
        listarAmigosTableView.reloadData()
    }
    
    private func naoFavoritado() {
        for i in 0...viewModel.favoritos.count {
            viewModel.favoritos[i] = false
        }
    }
}

extension ListarAmigosParaAdocaoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.obterQuantidadeDeAmigos(segmento: listarAmigosSegmentedControl.selectedSegmentIndex)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "caoCell") as? ListarAmigosCustomCell else { return UITableViewCell() }
        guard let vmCell = viewModel.obterViewModelParaCell(posicao: indexPath.row, segmento: listarAmigosSegmentedControl.selectedSegmentIndex) else { return UITableViewCell() }
        cell.configura(vm: vmCell)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detalheAmigoSegue", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalheAmigoSegue" {
            if let destination = segue.destination as? DetalheAmigoViewController {
                let vm = viewModel.obterViewModelParaDetalhes(posicao: sender)
                destination.configura(viewModel: vm)
            }
        }
    }
}

extension ListarAmigosParaAdocaoViewController: ListarAmigosViewModelDelegate {
    func listaDeAmigosFoiAlterada() {
        listarAmigosTableView.reloadData()
        finalizaActivityIndicator(activityIndicatorView: listarAmigosActivityIndicator)
    }
}



