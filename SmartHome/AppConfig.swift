//
//  AppConfig.swift
//  SmartHome
//
//  Created by Alpha on 3/11/20.
//  Copyright © 2020 Alpha. All rights reserved.
//

import Foundation

struct AppConfig {
    //static let SERVER_ADDRESS_DEFAULT = "https://smarthome116.herokuapp.com"
    //static let SERVER_ADDRESS_DEFAULT = "https://smart-home-hung.herokuapp.com"
    static let SERVER_ADDRESS_DEFAULT = "http://192.168.0.102:3484"
    static let SOCKET_NAMESPACE = "/ios"
    static let EVENT_RECEIVE_DATA = "DATA"
    static let EVENT_CONTROL = "CONTROL"
    
    static let den_tran_kh1 = "F1_D01"
    static let den_chum_kh1 = "F1_D02"
    static let den_tranh_kh1 = "F1_D03"
    static let quat_tran = "F1_D04"
    static let den_trangtri_kh1 = "F1_D05"
    static let den_tran_kh2 = "F1_D06"
    static let den_chum_kh2 = "F1_D07"
    static let den_tranh_kh2 = "F1_D08"
    static let den_san = "F1_D09"
    static let den_cong = "F1_D10"
    static let den_wc = "F1_D11"
    static let binh_nl = "F1_D12"
    static let den_cua_ngach = "F1_D13"
    static let den_bep_1 = "F1_D14"
    static let den_bep_2 = "F1_D15"
    static let khi_loc = "F1_D16"
    static let at_bep = "C_D01"
    static let at_tong = "C_D02"
    static let temp_humi = "C_S01"
    static let co = "C_S02"
    static let dong_dien = "C_S03"

    static let KEY_TEMP = "TEMP"
    static let KEY_HUMI = "HUMI"
    static let KEY_AMPE = "AMP"
    static let KEY_VOLTAGE = "VOL"
    static let KEY_ENERGY = "ENERGY"
}
