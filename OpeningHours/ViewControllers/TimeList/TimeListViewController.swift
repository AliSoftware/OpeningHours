//
//  TimeListViewController.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 28/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

class TimeListViewController: UITableViewController {

  // MARK: - Public Properties

  var timeTable: TimeTable = [:]

  // MARK: - UITableViewDataSource

  override func numberOfSections(in tableView: UITableView) -> Int {
    return Weekday.allCases.count
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return Weekday.allCases[section].description
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let day = Weekday.allCases[section]
    let ranges = timeTable[day] ?? []
    return ranges.isEmpty ? 1 : ranges.count // if none, show the TimeClosedCell
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let day = Weekday.allCases[indexPath.section]
    let ranges = timeTable[day] ?? []

    if ranges.isEmpty {
      return tableView.dequeueReusableCell(for: indexPath) as TimeClosedCell
    } else {
      let cell = tableView.dequeueReusableCell(for: indexPath) as TimeRowCell
      cell.timeLabel.text = ranges[indexPath.row].description
      return cell
    }
  }
}
