//
//  ViewController.swift
//  TableSpring
//
//  Created by Jozef Legény on 2020-01-18.
//  Copyright © 2020 yozy. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

  // We create a list of all the rows we want in the controller
  // each row is represented by two values, first is the type, as defined
  // in the reusable cell labels in the Storyboard and a Label, which is
  // just a text we want to print there
  let labels = [
    ["basic", "Main Title"],
    ["date", "Start"],
    ["datepicker", "Start Datepicker"],
    ["basic", "Some other label"],
    ["basic", "The labels should be unique"],
    ["date", "End"],
    ["datepicker", "End Datepicker"],
  ]

  // This variable holds the value of the row of the currently open datepicker
  // it is an optional (marked with ?) which means it can also hold no value.
  // If it is empty it means no datepicker is open.
  var openDatepicker: Int? = nil

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    1
  }

  // We have as many rows as we have defined sections above
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    labels.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: labels[indexPath.row][0]) else {
      fatalError()
    }

    // For the datepicker cells we do not wish to print a text label because
    // it would overlap it
    if labels[indexPath.row][0] == "basic" || labels[indexPath.row][0] == "date" {
      cell.textLabel?.text = labels[indexPath.row][1]
    }
    return cell
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    // Now, if we are currently at a "datepicker" cell, we need to check if it
    // should be open
    if labels[indexPath.row][0] == "datepicker" {
      // Our variable holds the current row = this datepicker is open, we set
      // the height to 200, the same value as in the storyboard
      if openDatepicker == indexPath.row {
        return 200
      } else {
        // otherwise it is closed and we set it to 0
        return 0
      }
    }

    // For other cells just send the default
    return UITableView.automaticDimension
  }

  // This method will serve us to open/close the datepickers
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // We handle only the case when the person taps on a "date" type row
    if labels[indexPath.row][0] == "date" {
      // If the datepicker is currently set to some value AND this value
      // is the row is the row below the one the user has tapped, we close
      // the datepicker, we do so by setting the open variable to nil
      if let row = openDatepicker, row == indexPath.row + 1{
        openDatepicker = nil
      } else {
        // Otherwise we open the datepicker on the row just below
        openDatepicker = indexPath.row + 1
      }
      tableView.reloadData()
    }

    // We deselect the current row, this is for animation purposes
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

