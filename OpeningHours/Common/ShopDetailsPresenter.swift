//
//  ShopDetailsUI.swift
//  OpeningHours
//
//  Created by Olivier HALLIGON on 30/08/2018.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

protocol ShopDetailsPresenter {
  var shop: Shop! { get set }
  func refresh()
}
