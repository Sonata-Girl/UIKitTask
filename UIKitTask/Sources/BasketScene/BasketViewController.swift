// BasketViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// BasketViewController
class BasketViewController: UIViewController {}

extension BasketViewController: ShoesDelegate {
    func addShoes(sender: UIButton) {
        print("\(sender)")
    }
}
