//
//  ViewController.swift
//  BTCUN
//
//  Created by Евгений Лянкэ on 03.04.2022.
//

import UIKit

class ViewController: UIViewController,BTCManagerDelegate {
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var currancyLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var btcManager = BTCManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        btcManager.delegate = self
        btcManager.fetchCurency(selected: btcManager.currencyArray[0])
    }
}

extension ViewController:UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return btcManager.currencyArray.count
    }
}

extension ViewController:UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return btcManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        btcManager.fetchCurency(selected: btcManager.currencyArray[row])
    }
    
    func didUpdateRate(currencyRate: BTCModel){
        DispatchQueue.main.async {
            self.amountLabel.text = String(currencyRate.shortedRate)
            self.currancyLabel.text = currencyRate.currency
           
        }
        
    }
}

