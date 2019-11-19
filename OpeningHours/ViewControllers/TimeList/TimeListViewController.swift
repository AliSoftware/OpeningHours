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

  var shop: Shop!

  // MARK: - LifeCycle

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if
      let dayIndex = Weekday.ordered().firstIndex(of: .today),
      let activeRange = self.shop.timeTable.activeTimeRange(),
      let rangeIndex = self.shop.timeTable[.today].firstIndex(of: activeRange)
    {
      let indexPath = IndexPath(row: rangeIndex, section: dayIndex)
      self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
  }

  // MARK: - UITableViewDataSource

  override func numberOfSections(in tableView: UITableView) -> Int {
    return Weekday.ordered().count
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return weekday(for: section).description
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let day = weekday(for: section)
    let ranges = self.shop.timeTable[day]
    return ranges.isEmpty ? 1 : ranges.count // if none, show the TimeClosedCell
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let day = weekday(for: indexPath.section)
    let ranges = self.shop.timeTable[day]

    if ranges.isEmpty {
      return tableView.dequeueReusableCell(for: indexPath) as TimeClosedCell
    } else {
      let cell = tableView.dequeueReusableCell(for: indexPath) as TimeRowCell
      cell.setup(day: day, timeRange: ranges[indexPath.row])
      return cell
    }
  }

  override func tableView(_ tableView: UITableView,
                          editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let day = weekday(for: indexPath.section)
    var ranges = self.shop.timeTable[day]
    guard !ranges.isEmpty else { return [] }

    let delete = UITableViewRowAction(style: .destructive, title: L10n.ShopsList.delete) { (_, indexPath) in
      ranges.remove(at: indexPath.row)
      self.shop.timeTable[day] = ranges
      if ranges.isEmpty {
        // If we just deleted the last range and there are no ranges anymore
        // Then we'll show a TimeClosedCell instead, so we don't really _delete_ the row
        tableView.reloadRows(at: [indexPath], with: .fade)
      } else {
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
    }
    return [delete]
  }
}

// MARK: - Private Methods

private extension TimeListViewController {
  func weekday(for section: Int) -> Weekday {
    return Weekday.ordered()[section]
  }
}

// MARK: - ShopDetailsUI

extension TimeListViewController: ShopDetailsPresenter {
  func refresh() {
    self.tableView.reloadData()
  }
}
