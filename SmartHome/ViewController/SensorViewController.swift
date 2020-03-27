//
//  SensorViewController.swift
//  SmartHome
//
//  Created by Alpha on 3/3/20.
//  Copyright © 2020 Alpha. All rights reserved.
//

import UIKit

class SensorViewController: UIViewController {
    
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblHumi: UILabel!
    @IBOutlet weak var lblCO: UILabel!
    @IBOutlet weak var lblPower: UILabel!
    @IBOutlet weak var lblEnergy: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        SocketIOManager.sharedInstance.listenEventESP8266(completion: { data in
            if data[AppConfig.co] != nil || data[AppConfig.temp_humi] != nil || data[AppConfig.dong_dien] != nil{
                    Log("ESP8266 send: \(data)")
                    self.setupViews()
                    return
            }
            
        }, error: {
            let alert = UIAlertController(title: "Cảnh báo", message: "Đã có lỗi xảy ra khi cập nhật dữ liệu", preferredStyle: .alert)
            alert.addAction(title: "Ok")
            alert.show()
        })

    }
    @IBAction func cancelTaped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        //
        let temp = UserDefaultsUtils.getSavedDoubleData(nameKey: UserDefaultsUtils.temp, valueDefault: -1)
        if temp != -1 {
            lblTemp.text = "\(temp.cleanValue)°C"
            lblTemp.textColor = .darkText
        }else{
            lblTemp.text = "all_lbl_error".localized
            lblTemp.textColor = UIColor(named: "colorError")
        }
        
        let humi = UserDefaultsUtils.getSavedDoubleData(nameKey: UserDefaultsUtils.humi, valueDefault: -1)
        if humi != -1 {
            lblHumi.text = "\(humi.cleanValue)%"
            lblHumi.textColor = .darkText
        }else{
            lblHumi.text = "all_lbl_error".localized
            lblHumi.textColor = UIColor(named: "colorError")
        }
        
        let co = UserDefaultsUtils.getSavedDoubleData(nameKey: UserDefaultsUtils.co, valueDefault: -1)
        if co != -1 {
            lblCO.text = "\(co.cleanValue)/400"
            lblCO.textColor = .darkText
        }else{
            lblCO.text = "all_lbl_error".localized
            lblCO.textColor = UIColor(named: "colorError")
        }
        
        let amp = UserDefaultsUtils.getSavedDoubleData(nameKey: UserDefaultsUtils.dongdien_amp, valueDefault: -1)
        let vol = UserDefaultsUtils.getSavedDoubleData(nameKey: UserDefaultsUtils.dongdien_vol, valueDefault: -1)
        if amp != -1 && vol != -1{
            lblPower.text = "\(vol.cleanValue)/\(amp.cleanValue) (V/A)"
            lblPower.textColor = .darkText
        }else{
            lblPower.text = "all_lbl_error".localized
            lblPower.textColor = UIColor(named: "colorError")
        }
        
        let energy = UserDefaultsUtils.getSavedDoubleData(nameKey: UserDefaultsUtils.congsuat_tieuthu, valueDefault: -1)
        if energy != -1 {
            if energy >= 1000{
                let mw = Int(energy/1000)
                let kw = Int(energy.truncatingRemainder(dividingBy: 1000))
                lblEnergy.text = "\(mw)MW - \(kw)KW"
            }else{
                lblEnergy.text = "\(energy.cleanValue) KW"
            }
            
            lblEnergy.textColor = .darkText
        }else{
            lblEnergy.text = "all_lbl_error".localized
            lblEnergy.textColor = UIColor(named: "colorError")
        }
    }
    

}


