//
//  FavoritosViewController.swift
//  AdoCao
//
//  Created by André N. dos Santos on 11/06/22.
//

import UIKit
import SwiftUI

class FavoritosViewController: UIViewController {

    @IBOutlet weak var backgroundTopView: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var favoritosCollectionView: UICollectionView!
    let viewModel: FavoritosViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        favoritosCollectionView.dataSource = self
        favoritosCollectionView.delegate = self
        
        topView.roundCorners(cornerRadius: 20.0, cornerType: [.inferiorDireito, .inferiorEsquerdo])
        backgroundTopView.roundCorners(cornerRadius: 20.0, cornerType: [.inferiorDireito, .inferiorEsquerdo])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritosCollectionView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let telaDetalhes = segue.destination as? DetalheAmigoViewController else { return }
        guard let posicao = sender as? Int else { return }
        let vmDetalhes = viewModel.obterViewModelParaTelaDetalhe(posicao: posicao)
        telaDetalhes.configura(viewModel: vmDetalhes, tipoOperacao: TipoListagem.Adocao)
    }
}

// MARK: - CollectionView Delegate
extension FavoritosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detalheAmigoSegue", sender: indexPath.item)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - CollectionView Datasource
extension FavoritosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.obterQuantidadeDeFavoritos()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //recarregarTela()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritoCell", for: indexPath) as? FavoritoCollectionViewCell {
            if let vmCell = viewModel.obterViewModelParaCell(posicao: indexPath.item) {
                cell.configura(vm: vmCell)
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

// MARK: - ViewModel Delegate
extension FavoritosViewController: FavoritosViewModelDelegate {
    func recarregarTela() {
        favoritosCollectionView.reloadData()
    }
}
