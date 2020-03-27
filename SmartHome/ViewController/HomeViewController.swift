//
//  HomeViewController.swift
//  SmartHome
//
//  Created by Alpha on 3/3/20.
//  Copyright © 2020 Alpha. All rights reserved.
//

import UIKit
import SocketIO

class HomeViewController: UIViewController {
    let CELL_2_STATE = "CELL_2_STATE"
    let CELL_3_STATE = "CELL_3_STATE"
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SocketIOManager.sharedInstance.listenEventESP8266(completion: { data in
            if data[AppConfig.co] == nil && data[AppConfig.temp_humi] == nil && data[AppConfig.dong_dien] == nil{
                Log("ESP8266 send: \(data)")
                self.tableView.reloadData()
                return
            }
            
        }, error: {
            let alert = UIAlertController(title: "Cảnh báo", message: "Đã có lỗi xảy ra khi cập nhật dữ liệu", preferredStyle: .alert)
            alert.addAction(title: "Ok")
            alert.show()
        })
        setupViews()
        loadDataAfterOpenApp()
        
    }
    
    
    func setupViews() {
        navigationItem.title = "Điều khiển các thiết bị"
        let view = UIBarButtonItem(title: "Cảm biến", style: .plain, target: self, action: #selector(viewTaped))
        navigationItem.rightBarButtonItems = [view]
        setupTableView()
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu...")
        refreshControl.addTarget(self, action: #selector(updateData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    func setupTableView() {
        tableView.register(UINib.init(nibName: "Control2StateCell", bundle: nil), forCellReuseIdentifier: CELL_2_STATE)
        tableView.register(UINib.init(nibName: "Control3StateCell", bundle: nil), forCellReuseIdentifier: CELL_3_STATE)
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
    }
    
    @objc private func updateData(_ sender: Any) {
        SocketIOManager.sharedInstance.refreshData()
        view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
            self.refreshControl.endRefreshing()
            self.view.isUserInteractionEnabled = true
        }
        
    }
    func loadDataAfterOpenApp() {
        view.isUserInteractionEnabled = false
        refreshControl.beginRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
            self.refreshControl.endRefreshing()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    
    @objc private func viewTaped(_ sender: Any) {
        self.present(SensorViewController(), animated: true, completion: nil)
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        if index == 3 || index == 15{
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_3_STATE, for: indexPath) as! Control3StateCell
            
            let tapOn = UITapGestureRecognizer(target: self, action: #selector(actionTapOn))
            cell.btnOn.addGestureRecognizer(tapOn)
            let tapOff = UITapGestureRecognizer(target: self, action: #selector(actionTapOff))
            cell.btnOff.addGestureRecognizer(tapOff)
            if index == 3 {
                cell.lblDevice.text = "Quạt trần"
                let value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.quat_tran, valueDefault: -1)
                if (value == 0 || value == 1 || value == 2 || value == 3){
                    if value == 0{
                        cell.lblValue.text = "all_lbl_off".localized
                        cell.lblValue.textColor = UIColor(named: "colorOff")
                    }else{
                        cell.lblValue.text = "Tốc độ: \(value)"
                        cell.lblValue.textColor = UIColor(named: "colorOn")
                    }
                }else{
                    cell.lblValue.text = "all_lbl_error".localized
                    cell.lblValue.textColor = UIColor(named: "colorError")
                }
            }else{
                cell.lblDevice.text = "Khí lọc"
                let value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.khi_loc, valueDefault: -1)
                if (value == 0 || value == 1 || value == 2 || value == 3){
                    if value == 0{
                        cell.lblValue.text = "all_lbl_off".localized
                        cell.lblValue.textColor = UIColor(named: "colorOff")
                    }else{
                        cell.lblValue.text = "Tốc độ: \(value)"
                        cell.lblValue.textColor = UIColor(named: "colorOn")
                    }
                }else{
                    cell.lblValue.text = "all_lbl_error".localized
                    cell.lblValue.textColor = UIColor(named: "colorError")
                }
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_2_STATE, for: indexPath) as! Control2StateCell
            let tapChange = UITapGestureRecognizer(target: self, action: #selector(actionChangeState))
            cell.btnChange.addGestureRecognizer(tapChange)
            
            var value = -1
            if index == 0 {
                cell.lblDevice.text = "Đèn trần KH1"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.den_tran_kh1, valueDefault: -1)
            }else if index == 1{
                cell.lblDevice.text = "Đèn chùm KH1"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.den_chum_kh1, valueDefault: -1)
                
            }
            else if index == 2{
                cell.lblDevice.text = "Đèn tranh KH1"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.den_tranh_kh1, valueDefault: -1)
            }else if index == 4{
                cell.lblDevice.text = "Đèn trang trí KH1"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.den_trangtri_kh1, valueDefault: -1)
            }
            else if index == 5{
                cell.lblDevice.text = "Đèn trần KH2"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.den_tran_kh2, valueDefault: -1)
                
            }else if index == 6{
                cell.lblDevice.text = "Đèn chùm KH2"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.den_chum_kh2, valueDefault: -1)
            }
            else if index == 7{
                cell.lblDevice.text = "Đèn tranh KH2"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.den_tranh_kh2, valueDefault: -1)
            }else if index == 8{
                cell.lblDevice.text = "Đèn sân"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.den_san, valueDefault: -1)
            }else if index == 9{
                cell.lblDevice.text = "Đèn cổng"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.den_cong, valueDefault: -1)
            }else if index == 10{
                cell.lblDevice.text = "Đèn WC"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.den_wc, valueDefault: -1)
            }else if index == 11{
                cell.lblDevice.text = "Bình NL"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.binh_nl, valueDefault: -1)
            }else if index == 12{
                cell.lblDevice.text = "Đèn cửa ngách"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.den_cua_ngach, valueDefault: -1)
            }else if index == 13{
                cell.lblDevice.text = "Đèn 1 bếp"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.den_bep_1, valueDefault: -1)
            }else if index == 14{
                cell.lblDevice.text = "Đèn 2 bếp"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.den_bep_2, valueDefault: -1)
            }else if index == 16{
                cell.lblDevice.text = "AT bếp"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.at_bep, valueDefault: -1)
            }else if index == 17{
                cell.lblDevice.text = "AT tổng"
                value = UserDefaultsUtils.getSavedIntData(nameKey: UserDefaultsUtils.at_tong, valueDefault: -1)
            }
            //set value
            if value == 0 {
                cell.lblValue.text = "all_lbl_off".localized
                cell.lblValue.textColor = UIColor(named: "colorOff")
            }else if(value == 1){
                cell.lblValue.text = "all_lbl_on".localized
                cell.lblValue.textColor = UIColor(named: "colorOn")
            }else{
                cell.lblValue.text = "all_lbl_error".localized
                cell.lblValue.textColor = UIColor(named: "colorError")
            }
            return cell
        }
    }
    
    @objc func actionChangeState(recognizer: UITapGestureRecognizer){
        //add effect button
        if let button = recognizer.view as? UIButton{
            button.backgroundColor = .green
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                button.backgroundColor = .clear
            })
        }
        
        if recognizer.state == UIGestureRecognizer.State.ended {
            let tapLocation = recognizer.location(in: self.tableView)
            if let indexPath = self.tableView.indexPathForRow(at: tapLocation) {
                var json: [String: String] = [:]
                let index = indexPath.row
                if index == 0{
                    Log("Change đèn trần KH1")
                    json[AppConfig.den_tran_kh1] = "change"
                }else if index == 1{
                    Log("Change đèn chùm KH1")
                    json[AppConfig.den_chum_kh1] = "change"
                }else if index == 2{
                    Log("Change đèn tranh KH1")
                    json[AppConfig.den_tranh_kh1] = "change"
                }else if index == 4{
                    Log("Change đèn trang trí KH1")
                    json[AppConfig.den_trangtri_kh1] = "change"
                }else if index == 5{
                    Log("Change đèn trần KH2")
                    json[AppConfig.den_tran_kh2] = "change"
                }else if index == 6{
                    Log("Change đèn chùm KH2")
                    json[AppConfig.den_chum_kh2] = "change"
                }else if index == 7{
                    Log("Change đèn tranh KH2")
                    json[AppConfig.den_tranh_kh2] = "change"
                }else if index == 8{
                    Log("Change đèn sân")
                    json[AppConfig.den_san] = "change"
                }else if index == 9{
                    Log("Change đèn cổng")
                    json[AppConfig.den_cong] = "change"
                }else if index == 10{
                    Log("Change đèn WC")
                    json[AppConfig.den_wc] = "change"
                }else if index == 11{
                    Log("Change bình nóng lạnh")
                    json[AppConfig.binh_nl] = "change"
                }else if index == 12{
                    Log("Change đèn cửa ngách")
                    json[AppConfig.den_cua_ngach] = "change"
                }else if index == 13{
                    Log("Change đèn 1 bếp")
                    json[AppConfig.den_bep_1] = "change"
                }else if index == 14{
                    Log("Change đèn 2 bếp")
                    json[AppConfig.den_bep_2] = "change"
                }else if index == 16{
                    Log("Change AT bếp")
                    json[AppConfig.at_bep] = "change"
                }else if index == 17{
                    Log("Change AT Tổng")
                    json[AppConfig.at_tong] = "change"
                }
                SocketIOManager.sharedInstance.sendToESP8266(json: json)
            }
        }
    }
    @objc func actionTapOn(recognizer: UITapGestureRecognizer){
        //add effect button
        if let button = recognizer.view as? UIButton{
            button.backgroundColor = .green
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                button.backgroundColor = .clear
            })
        }
        if recognizer.state == UIGestureRecognizer.State.ended {
            let tapLocation = recognizer.location(in: self.tableView)
            if let indexPath = self.tableView.indexPathForRow(at: tapLocation) {
                let index = indexPath.row
                var json: [String: String] = [:]
                if index == 3 {
                    Log("On quạt trần")
                    json[AppConfig.quat_tran] = "on"
                }else{
                    Log("On khí lọc")
                    json[AppConfig.khi_loc] = "on"
                }
                SocketIOManager.sharedInstance.sendToESP8266(json: json)
            }
        }
    }
    @objc func actionTapOff(recognizer: UITapGestureRecognizer){
        //add effect button
        if let button = recognizer.view as? UIButton{
            button.backgroundColor = .green
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                button.backgroundColor = .clear
            })
        }
        if recognizer.state == UIGestureRecognizer.State.ended {
            let tapLocation = recognizer.location(in: self.tableView)
            if let indexPath = self.tableView.indexPathForRow(at: tapLocation) {
                let index = indexPath.row
                var json: [String: String] = [:]
                if index == 3 {
                    Log("Off quạt trần")
                    json[AppConfig.quat_tran] = "off"
                }else{
                    Log("Off khí lọc")
                    json[AppConfig.khi_loc] = "off"
                }
                SocketIOManager.sharedInstance.sendToESP8266(json: json)
            }
        }
    }
    
    
}
