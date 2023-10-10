//
//  Logging.swift
//  DarkMode
//
//  Created by Peter Forward on 10/1/23.
//

import Foundation

public func logMsg(msg: String) {
    // *** Create date ***
    let date = Date()

    // *** create calendar object ***
    var calendar = Calendar.current

    // *** Get components using current Local & Timezone ***
    //print(calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date))

    // *** define calendar components to use as well Timezone to UTC ***
    calendar.timeZone = TimeZone(identifier: "UTC")!

    // *** Get All components from date ***
    //let components = calendar.dateComponents([.hour, .year, .minute], from: date)
    //print("All Components : \(components)")

    // *** Get Individual components from date ***
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    let seconds = calendar.component(.second, from: date)
    let nanoSeconds = calendar.component(.nanosecond, from: date)
    print("\(hour):\(minutes):\(seconds).\(nanoSeconds) \(msg)")
}
