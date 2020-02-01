//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = TextClassifier()
    
    // Iniciando uma instancia da framework. Passando para ela os dados necessarios para autenticar com a API.
    let swifter = Swifter(consumerKey: APIData.API_KEY, consumerSecret: APIData.SECRET_KEY)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Abaixo estamos fazendo a predicao de uma simples frase e acessando a label atribuida pelo modelo.
//        let prediction =  try! sentimentClassifier.prediction(text: "I love banana")
//        print(prediction.label)
        
    }

    @IBAction func predictPressed(_ sender: Any) {
        
        print(textField.text!)
        // Temos dois clojures abaixo, um que e chamado caso a busca seja bem sucedida e outro que e chamado caso aconteca algum erro
        // count: quantidade de tweets por pagina, o maximo e 100.
        // extended: queremos tweets completos e nao truncados.
        swifter.searchTweet(using: textField.text!, lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
            
            //O nomeda classe que representa o modelo e TextClassifier
            // Dentro dessa classe existe um tiopo de dado TextClassifierInput que deve ser criado caso voce queria predizer um batch de dados de entrada. Veja que vamos montar um array contendo esse datatyp nas linhas abaixo.
            var tweets = [TextClassifierInput]()
            //O loop abaixo extrai apenas os textos dos dados retirados do JSON.
            for i in 0..<100 {
                //Como estamos usando uma framework implementada em Swift, a resposta que chega aqui ja esta no datatype JSON. Entao so precisamos consumir os dados!
                if let tweet = results[i]["full_text"].string {
                    let tweetForClassification = TextClassifierInput(text: tweet)
                    tweets.append(tweetForClassification)
                }
            }
            
            do{
                // Vamos receber um array com a predicao de cada entrada
                let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
                
                var sentimentalScore = 0
                for i in 0..<predictions.count {
                    if predictions[i].label == "Pos"{
                        sentimentalScore += 1
                    }else if predictions[i].label  == "Neg"{
                        sentimentalScore -= 1
                    }
                }
                print(sentimentalScore)
                
            }catch{
                print(error)
            }
        }) { (error) in
            print(error)
        }
    }
    
}

