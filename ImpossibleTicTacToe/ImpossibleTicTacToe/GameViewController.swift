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
  private var isGameOver: Bool = false
  private var isPlayer1Turn: Bool = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
    setUpSubviews()
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
    
  }
  
  private func makeX() {
    let x = UIImageView(image: UIImage(systemName: "xmark"))
    x.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(x)
    x.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*16/60).isActive = true
    x.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*16/60).isActive = true
    x.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    x.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
  }
  
  private func makeO() {
    let o = UIImageView(image: UIImage(systemName: "circle"))
    o.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(o)
    o.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*16/60).isActive = true
    o.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*16/60).isActive = true
    o.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    o.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
  }
  
}

