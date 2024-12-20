//
//  DashboardController.swift
//  examenIOS
//
//  Created by ISAIAS PEDRO HERNANDEZ  on 19/12/24.
//


import UIKit

class DashboardController: UIViewController {
    @IBOutlet weak var imgdog: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    @IBAction func updateDog(_ sender: Any) {
        
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            print("URL inválida.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error en la petición: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(RespuestaDogModel.self, from: data)
                    print("Imagen de perro: \(result.message)")
                    
                    // Cargar la imagen en la UI
                    self.loadDogImage(from: result.message, into: self.imgdog)
                } catch {
                    print("Error al decodificar: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    func loadDogImage(from urlString: String, into imageView: UIImageView) {
        guard let url = URL(string: urlString) else {
            print("URL inválida para la imagen.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error al cargar la imagen: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }.resume()
    }
}
