//
//  BTCManager.swift
//  BTCUN
//
//  Created by Евгений Лянкэ on 03.04.2022.
//

import Foundation
protocol BTCManagerDelegate {
    func didUpdateRate(currencyRate: BTCModel)
}
class BTCManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "8DA959D3-F617-42D6-A778-BE99AB923090"
    var selectedCurency = "AUD"
    var delegate: BTCManagerDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func fetchCurency(selected currency:String){
        selectedCurency = currency
         let urlString = ("\(baseURL)/\(selectedCurency)?apikey=\(apiKey)")
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString:String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [self] data, urlResponse, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let btcModel = parseJson(with: safeData){
                        delegate?.didUpdateRate(currencyRate:btcModel)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJson(with data:Data)->BTCModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(BTCData.self, from: data)
            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            return BTCModel(currency: currency, rate: rate)
        }catch{
            print("parsing Error")
            return nil
        }
    }
}



