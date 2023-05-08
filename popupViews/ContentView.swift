//
//  ContentView.swift
//  popupViews
//
//  Created by Zakarai Lachkar on 8/5/2023.
//

import SwiftUI

struct ContentView: View {
    @State var nativeAlert = false
    @State var customAlert = false
    @State var HUB = false
    @State var password = ""
    var body: some View {
        VStack {
            Button {
                withAnimation {
                    nativeAlert.toggle()
                    alertView()
                }
            } label: {
                Text("Native Alert with TextField")
            }
            
            Text(password)
                .fontWeight(.bold)

        }
        .padding()
    }
    
    func alertView() {
        let alert = UIAlertController(title: "Login", message: "Enter Your Password", preferredStyle: .alert)
        
        alert.addTextField{ (pass) in
            pass.placeholder = "Password"
        }
        // Utilisation de la classe "UIActivity" au lieu de "UIAlertAction" pour "login"
        let login = UIAlertAction(title: "Login", style: .default) { _ in
            print("I'm logged in")
            customA()
            // Extraire le texte du champ de saisie de mot de passe et l'assigner à la variable "password"
                if let passwordField = alert.textFields?.first {
                    password = passwordField.text ?? ""
                }
        }

        // Utilisation de "UIAlertAction" avec le titre "Cancel" pour "cancel"
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Canceled")
        }
        alert.addAction(cancel)
        alert.addAction(login)
        // Récupérer toutes les scènes connectées à l'application
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            // Trouver la fenêtre pertinente et présenter l'alerte dessus
            if let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }    }
}

func customA() {
    // Créer une instance de UIViewController pour votre vue personnalisée
    let customViewController = UIViewController()
    customViewController.view = CustomView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

    // Ajouter la vue de votre contrôleur à une alerte native
    let alertController = UIAlertController(title: "Mon titre", message: "Ma description", preferredStyle: .alert)
    alertController.setValue(customViewController, forKey: "contentViewController")

    // Ajouter des actions à l'alerte
    let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
    let login = UIAlertAction(title: "Se connecter", style: .default, handler: nil)
    alertController.addAction(cancel)
    alertController.addAction(login)

    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            window.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}

// Créer une vue personnalisée avec un ZStack
class CustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        label.text = "test"
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
