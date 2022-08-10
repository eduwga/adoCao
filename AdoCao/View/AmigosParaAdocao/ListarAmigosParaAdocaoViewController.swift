//
//  ListarAmigosParaAdocaoViewController.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 31/05/22.
//

import UIKit

class ListarAmigosParaAdocaoViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var listarAmigosTableView: UITableView!
    @IBOutlet weak var listarAmigosSegmentedControl: UISegmentedControl!
    @IBOutlet weak var listarAmigosActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private Properties
    private let viewModel = ListarAmigosViewModel()

    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()

        iniciaActivityIndicator(activityIndicatorView: listarAmigosActivityIndicator)
        navigationItem.hidesBackButton = true
        listarAmigosTableView.dataSource = self
        listarAmigosTableView.delegate = self
        viewModel.delegate = self
        finalizaActivityIndicator(activityIndicatorView: listarAmigosActivityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listarAmigosTableView.reloadData()
    }
     
    // MARK: - IBActions
    @IBAction func segmentedButtonAction(_ sender: Any) {
        listarAmigosTableView.reloadData()
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
//        tabBarController?.navigationController?.popToRootViewController(animated: true)
        
        if let navigationController = navigationController {
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "telaLogin")
            navigationController.pushViewController(vc, animated: true)
        }
        
        //exibeAlertaSimples(mensagem: "saiu")
    }
}
// MARK: - TableView Datasource
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

// MARK: - TableView Delegate
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
                guard let tipoOperacao = TipoListagem(rawValue: listarAmigosSegmentedControl.selectedSegmentIndex) else { return }
                let vm = viewModel.obterViewModelParaDetalhes(posicao: sender, tipoOperacao: tipoOperacao)
                destination.configura(viewModel: vm, tipoOperacao: tipoOperacao)
            }
        }
    }
}
// MARK: - ViewModel Delegate
extension ListarAmigosParaAdocaoViewController: ListarAmigosViewModelDelegate {
    func listaDeAmigosFoiAlterada() {
        listarAmigosTableView.reloadData()
        finalizaActivityIndicator(activityIndicatorView: listarAmigosActivityIndicator)
    }
}



