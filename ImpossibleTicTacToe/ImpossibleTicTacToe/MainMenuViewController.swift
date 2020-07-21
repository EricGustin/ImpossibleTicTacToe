//
//  MainMenuViewController.swift
//  ImpossibleTicTacToe
//
//  Created by Eric Gustin on 7/20/20.
//  Copyright © 2020 Eric Gustin. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
  
  private let tictactoeImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "tictactoe@4x"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let difficultyButtons: [UIButton] = {
    let buttons = [UIButton(), UIButton(), UIButton(), UIButton()]
    buttons[0].setTitle("Easy", for: .normal)
    buttons[1].setTitle("Medium", for: .normal)
    buttons[2].setTitle("Hard", for: .normal)
    buttons[3].setTitle("Impossible", for: .normal)
    var i = 0
    for button in buttons {
      button.tag = i
      button.backgroundColor = .systemBlue
      button.layer.cornerRadius = 5
      i += 1
    }
    return buttons
  }()
  
  private var difficultyButtonsVStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 20
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setUpSubviews()
  }
  
  private func setUpSubviews() {
    view.addSubview(tictactoeImage)
    tictactoeImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75).isActive = true
    tictactoeImage.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75).isActive = true
    tictactoeImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    tictactoeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIScreen.main.bounds.height/16).isActive = true
    
    for button in difficultyButtons {
      button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToGameVC)))
      difficultyButtonsVStack.addArrangedSubview(button)
    }
    view.addSubview(difficultyButtonsVStack)
    difficultyButtonsVStack.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75).isActive = true
    difficultyButtonsVStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    difficultyButtonsVStack.topAnchor.constraint(equalTo: tictactoeImage.bottomAnchor, constant: UIScreen.main.bounds.height/16).isActive = true
  }
  
  @objc func goToGameVC(_ gestureRecognizer: UITapGestureRecognizer) {
    guard gestureRecognizer.view != nil else { return }
    
    let vc = GameViewController(levelDifficulty: Double(gestureRecognizer.view!.tag / 3))
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: false, completion: nil)
  }
}
