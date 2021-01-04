//
//  main.swift
//  CoronaChecker2
//
//  Created by Amir Hayek on 04/01/2021.
//

import AppKit
import CoreWLAN

let defaultsKey = "lastRun"

var ssid: String {
    return CWWiFiClient.shared().interface(withName: nil)?.ssid() ?? ""
}

let lastRun = (UserDefaults.standard.object(forKey: defaultsKey) as? Date) ?? Calendar.current.date(byAdding: .day, value: -1, to: Date())!

if Calendar.current.isDateInYesterday(lastRun) {
    var triesToDo = 50
    
    while triesToDo > 0 {
        triesToDo = doit() == true ? 0 : triesToDo - 1
        sleep(10)
    }
}


func doit() -> Bool {
    if ssid == "SFLY_GUEST" || ssid == "SFLY_CORP" {
        UserDefaults.standard.set(Date(), forKey: defaultsKey)
        
        let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSd88_KFhpQOcyOxvB5b_FWVc991u7sz25qaatcrgqxnYD4itg/viewform")!
        NSWorkspace.shared.open(url)
        return true
    }
    
    return false
}
