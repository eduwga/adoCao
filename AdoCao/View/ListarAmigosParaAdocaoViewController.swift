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

        iniciaActivityIndicator()
        navigationItem.hidesBackButton = true
        listarAmigosTableView.dataSource = self
        listarAmigosTableView.delegate = self
        viewModel.delegate = self
//        customCell?.favoritarImageView.image = UIImage(named: "heart")
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(customCell.clickFavorito(customCell?.clickImage(tapGestureRecognizer:))))
        

        
    }
    
    @IBAction func segmentedButtonAction(_ sender: Any) {
        listarAmigosTableView.reloadData()
    }
    
    private func iniciaActivityIndicator() {
        listarAmigosActivityIndicator.startAnimating()
        listarAmigosActivityIndicator.isHidden = false
        listarAmigosActivityIndicator.color = UIColor.purple
        listarAmigosActivityIndicator.style = .large
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
        self.listarAmigosActivityIndicator.stopAnimating()
        self.listarAmigosActivityIndicator.isHidden = true
        }
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
        cell.configura(cao: viewModel.obterAmigoPela(posicao: indexPath.row, segmento: listarAmigosSegmentedControl.selectedSegmentIndex)!)
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
//        let seleCao = service.listaDeCaesQueOServidorConhece()[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! ListarAmigosCustomCell
//        cell.favoritarImageView.image = UIImage(systemName: "heart.fill")
        viewModel.favoritos[indexPath.row] = true
        performSegue(withIdentifier: "detalheAmigoSegue", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ListarAmigosCustomCell
//        cell.favoritarImageView.image = UIImage(systemName: "heart")
        viewModel.favoritos[indexPath.count] = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalheAmigoSegue" {
            if let destination = segue.destination as? DetalheAmigoViewController {
                let vm = viewModel.obterViewModelParaDetalhes(posicao: sender)
                destination.viewModel = vm
            }
        }
    }
}

extension ListarAmigosParaAdocaoViewController: ListarAmigosViewModelDelegate {
    
}



