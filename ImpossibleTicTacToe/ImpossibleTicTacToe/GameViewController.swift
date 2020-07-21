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
  private var isPlayer1Turn = true
  private var turn = 0
  private var sumOfOutcomes = 0.0
  
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
    
    for row in 0...2 {
      for col in 0...2 {
        boardClickableCompartments[row][col].tag = 3*row + col
        boardClickableCompartments[row][col].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(boardClicked)))
        boardClickableCompartments[row][col].translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardClickableCompartments[row][col])
        boardClickableCompartments[row][col].widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*18/60).isActive = true
        boardClickableCompartments[row][col].heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*18/60).isActive = true
        switch row {
          case 0:
            boardClickableCompartments[row][col].centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -UIScreen.main.bounds.width*32.5/100).isActive = true
          case 1:
            boardClickableCompartments[row][col].centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
          case 2:
            boardClickableCompartments[row][col].centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: UIScreen.main.bounds.width*32.5/100).isActive = true
          default: return
        }
        switch col {
          case 0:
            boardClickableCompartments[row][col].centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -UIScreen.main.bounds.width*1/3).isActive = true
          case 1:
            boardClickableCompartments[row][col].centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
          case 2:
            boardClickableCompartments[row][col].centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: UIScreen.main.bounds.width*1/3).isActive = true
          default: return
        }
      }
    }
  }
  
  private func gameLoop() {
    if isGameOver(currentPosition: board) == 0 && !isNoMoreMoves(position: board) {
      turn += 1
      if turn % 2 == 1 {  // player1's turn
        isPlayer1Turn = true
      } else {  // computer's turn
        isPlayer1Turn = false
        var bestScore = -Double.infinity
        var move = (0, 0)
        for row in 0...2 {
          for col in 0...2 {
            if board[row][col] == "" {
              board[row][col] = oSystemName
              let score = minimax(curBoard: board, depth: 0, isMaximizing: false)
              board[row][col] = ""
              if score > bestScore {
                bestScore = score
                move = (row, col)
              }
            }
          }
        }
        board[move.0][move.1] = oSystemName
        makeSymbol(systemName: oSystemName, row: move.0, col: move.1)
      }
    } else {
      endGame()
    }
  }
  
  private func minimax(curBoard: [[String]], depth: Double, isMaximizing: Bool) -> Double {
    var varCurBoard = curBoard
    let result = isGameOver(currentPosition: curBoard)
    if result == 10.0 {
      return result
    } else if result == -10.0 {
      return result
    } else if isNoMoreMoves(position: curBoard) {
      return 0
    }
    
    if isMaximizing {
      var bestScore = -Double.infinity
      for row in 0...2 {
        for col in 0...2 {
          if varCurBoard[row][col] == "" {
            varCurBoard[row][col] = oSystemName
            let score = minimax(curBoard: varCurBoard, depth: depth+1, isMaximizing: !isMaximizing)
            varCurBoard[row][col] = ""
            bestScore = max(score, bestScore)
          }
        }
      }
      return bestScore
    }
    else {
      var bestScore = Double.infinity
      for row in 0...2 {
        for col in 0...2 {
          if varCurBoard[row][col] == "" {
            varCurBoard[row][col] = xSystemName
            let score = minimax(curBoard: varCurBoard, depth: depth+1, isMaximizing: !isMaximizing)
            varCurBoard[row][col] = ""
            bestScore = min(score, bestScore)
          }
        }
      }
      return bestScore
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
    board[row][col] = systemName
    gameLoop() // go to next turn
  }
  
  @objc func boardClicked(_ gestureRecognizer: UITapGestureRecognizer) {
    if !isPlayer1Turn { return }
    guard gestureRecognizer.view != nil else { return }
    let row = Int(gestureRecognizer.view!.tag / 3)
    let col = gestureRecognizer.view!.tag % 3
    if board[row][col] == "" {
      makeSymbol(systemName: xSystemName, row: row, col: col)
    }
  }
  
  private func isGameOver(currentPosition: [[String]]) -> Double {
    if (currentPosition[0][0] == oSystemName && ((currentPosition[0][0] == currentPosition[0][1] && currentPosition[0][0] == currentPosition[0][2]) ||
      (currentPosition[0][0] == currentPosition[1][0] && currentPosition[0][0] == currentPosition[2][0]) ||
      (currentPosition[0][0] == currentPosition[1][1] && currentPosition[0][0] == currentPosition[2][2]))) ||
      (currentPosition[2][2] == oSystemName && ((currentPosition[2][2] == currentPosition[2][1] && currentPosition[2][2] == currentPosition[2][0]) ||
      currentPosition[2][2] == currentPosition[1][2] && currentPosition[2][2] == currentPosition[0][2])) ||
      (currentPosition[1][1] == oSystemName && ((currentPosition[1][1] == currentPosition[1][0] && currentPosition[1][1] == currentPosition[1][2]) ||
      (currentPosition[1][1] == currentPosition[0][1] && currentPosition[1][1] == currentPosition[2][1]) ||
      (currentPosition[1][1] == currentPosition[2][0] && currentPosition[1][1] == currentPosition[0][2]))) {
      return 10.0
    } else if (currentPosition[0][0] == xSystemName && ((currentPosition[0][0] == currentPosition[0][1] && currentPosition[0][0] == currentPosition[0][2]) ||
    (currentPosition[0][0] == currentPosition[1][0] && currentPosition[0][0] == currentPosition[2][0]) ||
    (currentPosition[0][0] == currentPosition[1][1] && currentPosition[0][0] == currentPosition[2][2]))) ||
    (currentPosition[2][2] == xSystemName && ((currentPosition[2][2] == currentPosition[2][1] && currentPosition[2][2] == currentPosition[2][0]) ||
    currentPosition[2][2] == currentPosition[1][2] && currentPosition[2][2] == currentPosition[0][2])) ||
    (currentPosition[1][1] == xSystemName && ((currentPosition[1][1] == currentPosition[1][0] && currentPosition[1][1] == currentPosition[1][2]) ||
    (currentPosition[1][1] == currentPosition[0][1] && currentPosition[1][1] == currentPosition[2][1]) ||
    (currentPosition[1][1] == currentPosition[2][0] && currentPosition[1][1] == currentPosition[0][2]))) {
      return -10.0
    }
    return 0.0
  }
  
  private func isNoMoreMoves(position: [[String]]) -> Bool {
    for row in 0...2 {
      if position[row].contains("") {
        return false
      }
    }
    return true
  }
  
  private func endGame() {
    for row in 0...2 {
      for col in 0...2 {
        boardClickableCompartments[row][col].isUserInteractionEnabled = false
      }
    }
  }
}

