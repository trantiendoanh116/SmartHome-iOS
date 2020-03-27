//
//  UserDefaultsUtils.swift
//  SmartHome
//
//  Created by Alpha on 3/11/20.
//  Copyright © 2020 Alpha. All rights reserved.
//

import Foundation

public class UserDefaultsUtils {
    public static let SERVER_ADDRESS = "server_address"
    public static let SOCKET_NAMESPACE = "namespace_getdata"
    public static let den_tran_kh1 = "F1_D01"
    public static let den_chum_kh1 = "F1_D02"
    public static let den_tranh_kh1 = "F1_D03"
    public static let quat_tran = "F1_D04"
    public static let den_trangtri_kh1 = "F1_D05"
    public static let den_tran_kh2 = "F1_D06"
    public static let den_chum_kh2 = "F1_D07"
    public static let den_tranh_kh2 = "F1_D08"
    public static let den_san = "F1_D09"
    public static let den_cong = "F1_D10"
    public static let den_wc = "F1_D11"
    public static let binh_nl = "F1_D12"
    public static let den_cua_ngach = "F1_D13"
    public static let den_bep_1 = "F1_D14"
    public static let den_bep_2 = "F1_D15"
    public static let khi_loc = "F1_D16"
    public static let at_bep = "C_D01"
    public static let at_tong = "C_D02"
    public static let temp = "C_S01_TEMP"
    public static let humi = "C_S01_HUMI"
    public static let co = "C_S02"
    public static let dongdien_amp = "C_S03_amp"
    public static let dongdien_vol = "C_S03_vol"
    public static let congsuat_tieuthu = "C_S03_ENERGY"
    init() {
        
    }
    
    public static func saveBoolData(nameKey: String, value: Bool) {
        UserDefaults.standard.set(value, forKey: nameKey)
    }
    
    public static func getBoolData(nameKey: String, valueDefault: Bool)-> Bool{
        
        let defaults = UserDefaults.standard
        
        if(defaults.value(forKey: nameKey) != nil) {
            return defaults.value(forKey: nameKey)! as! Bool
            
        } else {
            return valueDefault
        }
    }
    
    public static func saveStringData(nameKey: String,value: String){
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: nameKey)
        let didSave = preferences.synchronize()
        if !didSave {
            debugPrint("Not saved yet")
        }
    }
    
    public static func getSavedStringData(nameKey: String, valueDefault: String)-> String{
        let defaults = UserDefaults.standard
        if(defaults.value(forKey: nameKey) != nil){
            return defaults.value(forKey: nameKey) as! String
        } else {
            return valueDefault
        }
    }
    
    public static func saveArrayStringData(nameKey: String,value: Array<String>){
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: nameKey)
        let didSave = preferences.synchronize()
        if !didSave {
            debugPrint("Not saved yet")
        }
    }
    
    public static func getSavedArrayStringData(nameKey: String, valueDefault: Array<String>)-> Array<String>{
        let defaults = UserDefaults.standard
        if(defaults.value(forKey: nameKey) != nil){
            return defaults.value(forKey: nameKey) as! Array<String>
        } else {
            return valueDefault
        }
    }
    
    public static func saveIntData(nameKey: String, value : Int){
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: nameKey)
        let didSave = preferences.synchronize()
        if !didSave {
            debugPrint("Not saved yet")
        }
    }
    
    public static func getSavedIntData(nameKey: String, valueDefault: Int) -> Int {
        let defaults = UserDefaults.standard
        if(defaults.value(forKey: nameKey) != nil){
            return defaults.value(forKey: nameKey) as! Int
        }else{
            return valueDefault
        }
    }
    
    public static func saveDoubleData(nameKey: String, value : Double){
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: nameKey)
        let didSave = preferences.synchronize()
        if !didSave {
            debugPrint("Not saved yet")
        }
    }
    
    public static func getSavedDoubleData(nameKey: String, valueDefault: Double) -> Double {
        let defaults = UserDefaults.standard
        if(defaults.value(forKey: nameKey) != nil){
            return defaults.value(forKey: nameKey) as! Double
        }else{
            return valueDefault
        }
    }
    
}
