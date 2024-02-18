// BasketViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для передачи данных
protocol ShoesDelegate: AnyObject {
    func addShoes(sender: UIButton)
}

/// BasketViewController
class BasketViewController: UIViewController {}

extension BasketViewController: ShoesDelegate {
    func addShoes(sender: UIButton) {
        print("\(sender)")
    }
}
