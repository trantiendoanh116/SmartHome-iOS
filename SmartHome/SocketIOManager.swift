//
//  SocketIOManager.swift
//  SmartHome
//
//  Created by Alpha on 3/6/20.
//  Copyright © 2020 Alpha. All rights reserved.
//

import UIKit
import SocketIO


class SocketIOManager: NSObject {

    static let sharedInstance = SocketIOManager()
    var manager = SocketManager(socketURL: URL(string: AppConfig.SERVER_ADDRESS_DEFAULT)!,config:[.reconnects(true)])
    var socket: SocketIOClient!
    var avaialableCallBack:(([Any]) -> Void)?
    override init() {
        socket = manager.socket(forNamespace: AppConfig.SOCKET_NAMESPACE)
        super.init()
    }
    
    func establishConnection() {
        Log("Socket connect......")
        socket.on("connect") { (data, ack) -> Void in
            Log("socket connected. Data = \(data), ack = \(ack)")
        }
        
        socket.on(clientEvent: .disconnect){data, ack in
            Log("socket disconnected")
        }
        
        socket.on("session-available") { (dataArr, ack) -> Void in
            ack.with(true)
            if let sessionAvailableCB = self.avaialableCallBack {
                sessionAvailableCB(dataArr)
            }
        }
        
        socket.connect()
    }
    
    
    func closeConnection() {
        Log("Socket disconnect......")
        socket.disconnect()
    }
    
    
    
    func listenEventESP8266(completion: @escaping(_ data: [String: Any]) -> Void, error: @escaping() -> Void) {
        socket.on(AppConfig.EVENT_RECEIVE_DATA){ data, ack in
            if let json = data[0] as? [String: Any]{
                self.processReceiveData(json: json)
                completion(json)
            }else{
                error()
            }
           
        }
        
    }
    
    func refreshData(){
        var json: [String: Bool] = [:]
        json["init"] = true
        socket.emit(AppConfig.EVENT_CONTROL, json)
        
    }
    
    func sendToESP8266(json:  [String: String]){
        socket.emit(AppConfig.EVENT_CONTROL, json)
        
    }
    
    func processReceiveData(json: [String: Any]) {
        if let value = json[AppConfig.den_tran_kh1]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.den_tran_kh1, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.den_chum_kh1]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.den_chum_kh1, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.den_tranh_kh1]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.den_tranh_kh1, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.quat_tran]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.quat_tran, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.den_trangtri_kh1]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.den_trangtri_kh1, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.den_tran_kh2]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.den_tran_kh2, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.den_chum_kh2]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.den_chum_kh2, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.den_tranh_kh2]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.den_tranh_kh2, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.den_san]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.den_san, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.den_cong]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.den_cong, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.den_wc]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.den_wc, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.binh_nl]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.binh_nl, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.den_cua_ngach]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.den_cua_ngach, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.den_bep_1]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.den_bep_1, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.den_bep_2]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.den_bep_2, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.khi_loc]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.khi_loc, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.at_bep]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.at_bep, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.at_tong]{
            UserDefaultsUtils.saveIntData(nameKey: UserDefaultsUtils.at_tong, value: value as? Int ?? -1)
        }
        if let value = json[AppConfig.temp_humi] as? [String: Any]{
            UserDefaultsUtils.saveDoubleData(nameKey: UserDefaultsUtils.temp, value: value[AppConfig.KEY_HUMI] as? Double ?? -1)
            UserDefaultsUtils.saveDoubleData(nameKey: UserDefaultsUtils.humi, value: value[AppConfig.KEY_TEMP] as? Double ?? -1)
        }
        if let value = json[AppConfig.co]{
            UserDefaultsUtils.saveDoubleData(nameKey: UserDefaultsUtils.co, value: value as? Double ?? -1)
        }
        if let value = json[AppConfig.dong_dien] as? [String: Any]{
            UserDefaultsUtils.saveDoubleData(nameKey: UserDefaultsUtils.dongdien_amp, value: value[AppConfig.KEY_AMPE] as? Double ?? -1)
            UserDefaultsUtils.saveDoubleData(nameKey: UserDefaultsUtils.dongdien_vol, value: value[AppConfig.KEY_VOLTAGE] as? Double ?? -1)
            UserDefaultsUtils.saveDoubleData(nameKey: UserDefaultsUtils.congsuat_tieuthu, value: value[AppConfig.KEY_ENERGY] as? Double ?? -1)
        }
    }
    
    //    func connectToServerWithNickname(nickname: String, completionHandler: (userList: [[String: AnyObject]]!) -> Void) {
    //        socket.emit("connectUser", nickname)
    //
    //        socket.on("userList") { ( dataArray, ack) -> Void in
    //            completionHandler(userList: dataArray[0] as! [[String: AnyObject]])
    //        }
    //
    //        listenForOtherMessages()
    //    }
    //
    //
    //    func exitChatWithNickname(nickname: String, completionHandler: () -> Void) {
    //        socket.emit("exitUser", nickname)
    //        completionHandler()
    //    }
    //
    //
    //    func sendMessage(message: String, withNickname nickname: String) {
    //        socket.emit("chatMessage", nickname, message)
    //    }
    //
    //
    //    private func listenForOtherMessages() {
    //        socket.on("userConnectUpdate") { (dataArray, socketAck) -> Void in
    //            NSNotificationCenter.defaultCenter().postNotificationName("userWasConnectedNotification", object: dataArray[0] as! [String: AnyObject])
    //        }
    //
    //        socket.on("userExitUpdate") { (dataArray, socketAck) -> Void in
    //            NSNotificationCenter.defaultCenter().postNotificationName("userWasDisconnectedNotification", object: dataArray[0] as! String)
    //        }
    //
    //        socket.on("userTypingUpdate") { (dataArray, socketAck) -> Void in
    //            NSNotificationCenter.defaultCenter().postNotificationName("userTypingNotification", object: dataArray[0] as? [String: AnyObject])
    //        }
    //    }
    //
    //
    //    func sendStartTypingMessage(nickname: String) {
    //        socket.emit("startType", nickname)
    //    }
    //
    //
    //    func sendStopTypingMessage(nickname: String) {
    //        socket.emit("stopType", nickname)
    //    }
}
