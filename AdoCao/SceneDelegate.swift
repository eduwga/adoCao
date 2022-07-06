//
//  SceneDelegate.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 26/05/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        verificaSeTemUsuarioLogado(windowScene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func login(email: String?, senha: String?, _ windowScene: UIWindowScene) {
        
        let service = Service.shared
        guard let email = email,
              let senha = senha
        else { return }
        
        //Efetua login com os dados salvos no CoreData
        service.login(email: email, password: senha, completion: { usuarioLogado in
            DispatchQueue.main.async {
                //instancia ViewController de Home
                let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let initialViewController = storyBoard.instantiateViewController(withIdentifier: "amigoParaAdocao")
                
                //muda root controller para a de home, para exibi-la
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = initialViewController
                self.window = window
                window.makeKeyAndVisible()
            }
        }) { error in
            print("Falha no login: \(error.localizedDescription)")
        }
    }
    
    func verificaSeTemUsuarioLogado(_ scene: UIWindowScene) {
        let coreDataService: CoreDataService = .init()
       
        let systemUser = coreDataService.pegaSystemUser()
        guard let systemUser = systemUser else { return }
        
        login(email: systemUser.email, senha: systemUser.senha, scene)
        //delegate?.temUsuarioLogado()
    }

}

