//
//  NewTimeRangeViewController.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 29/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

class NewTimeRangeViewController: UIViewController {

  // MARK: - Public Properties

  var selectedWeekdays: Set<Weekday> = []
  var selectedTimeRange: TimeRange = TimeRange(
    start: Time(hour: 9, minutes: 0),
    end: Time(hour: 12, minutes: 0)
  )
  var onValidate: (Set<Weekday>, TimeRange) -> Void = { _, _ in }

  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = L10n.NewTimeRange.title
    self.tableView.rowHeight = 36

    self.navigationItem.leftBarButtonItem =
      UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    self.navigationItem.rightBarButtonItem =
      UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(validate))
    self.navigationItem.rightBarButtonItem?.isEnabled = false

    picker.selectRow(selectedTimeRange.start.hour, inComponent: 0, animated: false)
    picker.selectRow(selectedTimeRange.start.minutes/5, inComponent: 1, animated: false)
    picker.selectRow(selectedTimeRange.end.hour, inComponent: 2, animated: false)
    picker.selectRow(selectedTimeRange.start.minutes/5, inComponent: 3, animated: false)
  }

  // MARK: - IBOutlets

  @IBOutlet private var weekTitleLabel: UILabel! {
    didSet {
      self.weekTitleLabel.text = L10n.NewTimeRange.weekdays
    }
  }
  @IBOutlet private var startTimeTitleLabel: UILabel! {
    didSet {
      self.startTimeTitleLabel.text = L10n.NewTimeRange.startTime
    }
  }
  @IBOutlet private var endTimeTitleLabel: UILabel! {
    didSet {
      self.endTimeTitleLabel.text = L10n.NewTimeRange.endTime
    }
  }
  @IBOutlet private var tableView: UITableView!
  @IBOutlet private var picker: UIPickerView!

  // MARK: - Private Methods

  @objc
  private func cancel() {
    self.presentingViewController?.dismiss(animated: true, completion: nil)
  }

  @objc
  private func validate() {
    self.onValidate(self.selectedWeekdays, self.selectedTimeRange)
    self.presentingViewController?.dismiss(animated: true, completion: nil)
  }
}

// MARK: - UITableViewDataSource

extension NewTimeRangeViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Weekday.ordered().count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    let day = weekday(for: indexPath.row)
    cell.textLabel?.text = day.description
    cell.accessoryType = selectedWeekdays.contains(day) ? .checkmark : .none
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let day = weekday(for: indexPath.row)
    if !selectedWeekdays.insert(day).inserted {
      selectedWeekdays.remove(day)
    }
    self.navigationItem.rightBarButtonItem?.isEnabled = !selectedWeekdays.isEmpty && self.selectedTimeRange.isValid
    tableView.reloadData()
  }

  private func weekday(for row: Int) -> Weekday {
    return Weekday.ordered()[row]
  }
}

// MARK: - UIPickerViewDataSource

extension NewTimeRangeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 4
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch component {
    case 0, 2:
      return 24
    case 1, 3:
      return 12
    default:
      fatalError("Unreachable component")
    }
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    switch component {
    case 0, 2:
      return String(format: "%d", row)
    case 1, 3:
      return String(format: "%02d", row*5)
    default:
      fatalError("Unreachable component")
    }
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch component {
    case 0: self.selectedTimeRange.start.hour = row
    case 1: self.selectedTimeRange.start.minutes = row*5
    case 2: self.selectedTimeRange.end.hour = row
    case 3: self.selectedTimeRange.end.minutes = row*5
    default: fatalError("Unreachable component")
    }

    if self.selectedTimeRange.end < self.selectedTimeRange.start {
      self.selectedTimeRange.end = self.selectedTimeRange.start
      pickerView.selectRow(self.selectedTimeRange.end.hour, inComponent: 2, animated: true)
      pickerView.selectRow(self.selectedTimeRange.end.minutes/5, inComponent: 3, animated: true)
    }
  }
}
