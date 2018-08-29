//
//  Clock.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 26/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation

class Clock {
  private let timer: Timer
  init(execute: @escaping () -> Void) {
    let zeroSeconds = DateComponents(second: 0)
    let nextMinute = Calendar.current.nextDate(
      after: Date(),
      matching: zeroSeconds,
      matchingPolicy: .nextTime
    )
    self.timer = Timer(fire: nextMinute ?? Date(), interval: 60, repeats: true) { _ in execute() }
    RunLoop.main.add(self.timer, forMode: .common)
  }
  deinit {
    self.timer.invalidate()
  }
}
