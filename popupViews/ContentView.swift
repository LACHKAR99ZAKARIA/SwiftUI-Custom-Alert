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
    
    @State private var showingModal = false
        
        var body: some View {
            ZStack {
                VStack(spacing: 20) {
                    Text("Custom Popup").font(.largeTitle)
                    
                    Text("Introduction").font(.title).foregroundColor(.gray)
                    
                    Text("You can create your own modal popup with the use of a ZStack and a State variable.")
                        .frame(maxWidth: .infinity)
                        .padding().font(.title).layoutPriority(1)
                        .background(Color.orange).foregroundColor(Color.white)
                    
                    Button(action: {
                        self.showingModal = true
                    }) {
                        Text("Show popup")
                    }
                    Spacer()
                }
                
                // The Custom Popup is on top of the screen
                if $showingModal.wrappedValue {
                    // But it will not show unless this variable is true
                    ZStack {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.vertical)
                        // This VStack is the popup
                        VStack(spacing: 20) {
                            Text("Popup")
                                .bold().padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .foregroundColor(Color.white)
                            Spacer()
                            Button(action: {
                                self.showingModal = false
                            }) {
                                Text("Close")
                            }.padding()
                        }
                        .frame(width: 300, height: 200)
                        .background(Color.white)
                        .cornerRadius(20).shadow(radius: 20)
                    }
                }
            }
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
    let login = UIAlertAction(title: "Se connecter", style: .default) { _ in
        customAView()
    }

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

func customAView() {
    // Créer une instance de la vue SwiftUI à afficher
    let customView = TramView()

    // Créer une instance de UIHostingController pour la vue SwiftUI
    let hostingController = UIHostingController(rootView: customView)

    // Présenter le UIHostingController modalement
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            window.rootViewController?.present(hostingController, animated: true, completion: nil)
        }
    }
}

struct TramView: View {
    var body: some View {
        VStack {
            Text("tram")
                .scaledToFit()
                .frame(width: 200, height: 100)
        }
        .frame(width: 200, height: 100)
    }
}


// Créer la vue SwiftUI à afficher
struct CustomSwiftUIView: View {
    var body: some View {
        ZStack {
            Color.white
            Text("test")
        }
        .frame(width: 200, height: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
