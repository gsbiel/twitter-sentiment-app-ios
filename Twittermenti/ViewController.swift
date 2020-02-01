//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    // Iniciando uma instancia da framework. Passando para ela os dados necessarios para autenticar com a API.
    let swifter = Swifter(consumerKey: APIData.API_KEY, consumerSecret: APIData.SECRET_KEY)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Temos dois clojures abaixo, um que e chamado caso a busca seja bem sucedida e outro que e chamado caso aconteca algum erro
        // count: quantidade de tweets por pagina, o maximo e 100.
        // extended: queremos tweets completos e nao truncados.
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
            print(results)
        }) { (error) in
            print(error)
        }
        
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

