//
//  BTCModel.swift
//  BTCUN
//
//  Created by Евгений Лянкэ on 04.04.2022.
//

import Foundation
struct BTCModel {
    var  currency:String
    var  rate:Double
    var shortedRate:String{
        return String(format: "%.01f", rate)
    }
}
