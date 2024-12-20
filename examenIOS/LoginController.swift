//
//  LoginController.swift
//  examenIOS
//
//  Created by ISAIAS PEDRO HERNANDEZ  on 19/12/24.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var sesion:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func iniciarSesion(_ sender: UIButton) {
        guard let email = user.text, !email.isEmpty,
                     let password = password.text, !password.isEmpty else {
                   showAlert(message: "Por favor, completa todos los campos.")
                   return
               }
        
     
            guard let url = URL(string: "https://reqres.in/api/login") else { return  }
            let parametros : [String:String] = ["email":email,"password":password]
            let body = try! JSONSerialization.data(withJSONObject: parametros)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { (data, response, _) in
                
                
                guard let data = data else { return }
                do {
                    let datos = try JSONDecoder().decode(Respuesta.self, from: data)
                    if datos.token == "QpwL5tke4Pnpja7X4" {
                        self.sesion = true
                        
                    }
                }catch{
                    print("error al logearse")
                    self.sesion = false
                    self.showAlert(message: "Credenciales incorrectas.")
                }
                
                
            }.resume()
        
               // Lógica de inicio de sesión
            if self.sesion{
                       print("go..")
                       performSegue(withIdentifier: "goToHome", sender: self)
                   }else{
                       self.showAlert(message: "Credenciales incorrectas.")
                   }
           }
           
           // Método para mostrar una alerta
           func showAlert(message: String) {
               let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }
}

