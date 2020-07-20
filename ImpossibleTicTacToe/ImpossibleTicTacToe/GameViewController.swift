//
//  ViewController.swift
//  ImpossibleTicTacToe
//
//  Created by Eric Gustin on 7/19/20.
//  Copyright © 2020 Eric Gustin. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  
  private let lines: [UIView] = {
    let views = [UIView(), UIView(), UIView(), UIView()]
    for view in views {
      view.backgroundColor = .black
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    return views
  }()
  
  private var boardClickableCompartments: [[UIView]] = [
    [UIView(), UIView(), UIView()],
    [UIView(), UIView(), UIView()],
    [UIView(), UIView(), UIView()]
  ]
  
  private var board: [[String]] = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""]
  ]
  
  private let xSystemName = "xmark"
  private let oSystemName = "circle"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
    setUpSubviews()
    makeSymbol(systemName: oSystemName, row: 1, col: 2)
    gameLoop()
  }
  
  private func setUpSubviews() {
    
    view.addSubview(lines[0])
    lines[0].heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95).isActive = true
    lines[0].widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.035).isActive = true
    lines[0].leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width*19/60).isActive = true
    lines[0].centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    view.addSubview(lines[1])
    lines[1].heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95).isActive = true
    lines[1].widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.035).isActive = true
    lines[1].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width*19/60).isActive = true
    lines[1].centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    view.addSubview(lines[2])
    lines[2].heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.035).isActive = true
    lines[2].widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95).isActive = true
    lines[2].centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    lines[2].centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -UIScreen.main.bounds.width*19/120).isActive = true
    view.addSubview(lines[3])
    lines[3].heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.035).isActive = true
    lines[3].widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95).isActive = true
    lines[3].centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    lines[3].centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: UIScreen.main.bounds.width*19/120).isActive = true
  }
  
  private func gameLoop() {
    for turn in 1...9 {
      if turn % 2 == 1 {  // player1's turn
        
      } else {  // computer's turn
        
      }
    }
  }
  
  private func makeSymbol(systemName: String, row: Int, col: Int) {
    let symbol = UIImageView(image: UIImage(systemName: systemName))
    symbol.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(symbol)
    symbol.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*16/60).isActive = true
    symbol.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*16/60).isActive = true
    switch row {
      case 0:
        symbol.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -UIScreen.main.bounds.width*19/60).isActive = true
      case 1:
        symbol.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
      case 2:
        symbol.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: UIScreen.main.bounds.width*19/60).isActive = true
      default: return
    }
    switch col {
      case 0:
        symbol.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -UIScreen.main.bounds.width*19/60).isActive = true
      case 1:
        symbol.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
      case 2:
        symbol.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: UIScreen.main.bounds.width*19/60).isActive = true
      default: return
    }
  }
}

