//
//  ShopInfoViewController.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 04/09/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import UIKit

class ShopInfoViewController: UIViewController {

  // MARK: - Public Types

  struct ShopInfo {
    var icon: Character?
    var name: String = ""
    var details: String = ""
  }

  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()

    self.iconTextField.placeholder = L10n.ShopInfo.Icon.placeholder
    self.nameTextField.placeholder = L10n.ShopInfo.Name.placeholder
    self.detailsTextField.placeholder = L10n.ShopInfo.Details.placeholder

    self.iconTextField.text = self.shopInfo.icon.map(String.init) ?? ""
    self.nameTextField.text = self.shopInfo.name
    self.detailsTextField.text = self.shopInfo.details
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.nameTextField.becomeFirstResponder()
  }

  // MARK: - Public Methods

  func configurePresentation(barButtonItem: UIBarButtonItem, completion: @escaping (ShopInfo?) -> Void) {
    let presCtrl = self.configurePresentation(completion: completion)
    presCtrl?.barButtonItem = barButtonItem
  }

  func configurePresentation(sourceView: UIView, sourceRect: CGRect, completion: @escaping (ShopInfo?) -> Void) {
    let presCtrl = self.configurePresentation(completion: completion)
    presCtrl?.sourceView = sourceView
    presCtrl?.sourceRect = sourceRect
  }

  func prefill(with shop: Shop) {
    self.shopInfo.icon = shop.icon.first
    self.shopInfo.name = shop.name
    self.shopInfo.details = shop.details
  }

  // MARK: - Private Properties

  private var completion: (ShopInfo?) -> Void = { _ in }
  private var shopInfo: ShopInfo = ShopInfo()

  // MARK: - IBOutlets

  @IBOutlet private var iconTextField: UITextField!
  @IBOutlet private var nameTextField: UITextField!
  @IBOutlet private var detailsTextField: UITextField!
}

// MARK: - Private Methods

private extension ShopInfoViewController {

  @IBAction
  func validate() {
    self.shopInfo.icon = self.iconTextField.text?.first
    self.shopInfo.name = self.nameTextField.text ?? ""
    self.shopInfo.details = self.detailsTextField.text ?? ""
    self.presentingViewController?.dismiss(animated: true) {
      self.completion(self.shopInfo)
    }
  }

  func configurePresentation(completion: @escaping (ShopInfo?) -> Void) -> UIPopoverPresentationController? {
    self.modalPresentationStyle = .popover
    self.preferredContentSize = CGSize(width: 300, height: 150)
    let popover = self.popoverPresentationController
    popover?.delegate = self
    self.completion = completion
    return popover
  }
}

// MARK: - UITextFieldDelegate

extension ShopInfoViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String
  ) -> Bool {
    switch textField {
    case iconTextField:
      self.iconTextField.text = string.last.map(String.init)
      return false
    default:
      return true
    }
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case iconTextField:
      self.nameTextField.becomeFirstResponder()
    case nameTextField:
      self.detailsTextField.becomeFirstResponder()
    case detailsTextField:
      self.validate()
    default: break
    }
    return false
  }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension ShopInfoViewController: UIPopoverPresentationControllerDelegate {
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none
  }

  func popoverPresentationControllerDidDismissPopover(
    _ popoverPresentationController: UIPopoverPresentationController
  ) {
    self.completion(nil)
  }
}
