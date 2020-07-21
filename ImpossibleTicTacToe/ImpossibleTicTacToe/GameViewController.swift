//
//  ViewController.swift
//  ImpossibleTicTacToe
//
//  Created by Eric Gustin on 7/19/20.
//  Copyright © 2020 Eric Gustin. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GameViewController: UIViewController, GADBannerViewDelegate {
  
  private var bannerView: GADBannerView!
  
  private let lines: [UIView] = {
    let views = [UIView(), UIView(), UIView(), UIView()]
    for view in views {
      view.backgroundColor = .black
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    return views
  }()
  
  private let refreshButton: UIButton = {
    let button = UIButton()
    button.setBackgroundImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
    button.tintColor = .black
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let homeButton: UIButton = {
    let button = UIButton()
    button.setBackgroundImage(UIImage(systemName: "house"), for: .normal)
    button.tintColor = .black
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
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
  
  private var symbols: [UIImageView] = []
  private let xSystemName = "xmark"
  private let oSystemName = "circle"
  private var isPlayer1Turn = true
  private var turn = 0
  private var levelDifficulty: Double = 0
  
  init(levelDifficulty: Double) {
    super.init(nibName: nil, bundle: nil)
    self.levelDifficulty = levelDifficulty
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
    setUpSubviews()
    gameLoop()
  }
  
  private func setUpSubviews() {
    
    bannerView = GADBannerView(adSize: kGADAdSizeBanner)
    bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
    bannerView.rootViewController = self
    bannerView.load(GADRequest())
    bannerView.delegate = self
    bannerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(bannerView)
    bannerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    bannerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
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
    
    refreshButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
    view.addSubview(refreshButton)
    refreshButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.1).isActive = true
    refreshButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.1).isActive = true
    refreshButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
    refreshButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    
    homeButton.addTarget(self, action: #selector(goToMainMenuVC), for: .touchUpInside)
    view.addSubview(homeButton)
    homeButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.1).isActive = true
    homeButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.1).isActive = true
    homeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
    homeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
  }
  
  private func gameLoop() {
    if isGameOver(currentPosition: board) == 0 && !isNoMoreMoves(position: board) {
      turn += 1
      if turn % 2 == 1 {  // player1's turn
        isPlayer1Turn = true
      } else {  // computer's turn
        isPlayer1Turn = false
        if (Double.random(in: 0..<1) - 0.6) > levelDifficulty {  // make random move
          while true {
            let randomRow = Int.random(in: 0...2)
            let randomCol = Int.random(in: 0...2)
            if board[randomRow][randomCol] == "" {
              board[randomRow][randomCol] = oSystemName
              makeSymbol(systemName: oSystemName, row: randomRow, col: randomCol)
              break
            }
          }
        } else {  // make optimal move
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
      }
    } else {
      endGame()
    }
  }
  
  private func minimax(curBoard: [[String]], depth: Double, isMaximizing: Bool) -> Double {
    var varCurBoard = curBoard
    let result = isGameOver(currentPosition: curBoard)
    if result == 10.0 {
      return result - depth
    } else if result == -10.0 {
      return result + depth
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
    symbols.append(UIImageView(image: UIImage(systemName: systemName)))
    symbols.last!.translatesAutoresizingMaskIntoConstraints = false
    if systemName == xSystemName {
      symbols.last!.tintColor = .systemBlue
    } else {
      symbols.last!.tintColor = .systemRed
    }
    view.addSubview(symbols.last!)
    symbols.last!.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*16/60).isActive = true
    symbols.last!.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*16/60).isActive = true
    switch row {
      case 0:
        symbols.last!.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -UIScreen.main.bounds.width*19/60).isActive = true
      case 1:
        symbols.last!.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
      case 2:
        symbols.last!.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: UIScreen.main.bounds.width*19/60).isActive = true
      default: return
    }
    switch col {
      case 0:
        symbols.last!.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -UIScreen.main.bounds.width*19/60).isActive = true
      case 1:
        symbols.last!.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
      case 2:
        symbols.last!.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: UIScreen.main.bounds.width*19/60).isActive = true
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
    UIView.animate(withDuration: 0.3) {
      
    }
    UIView.animate(withDuration: 0.3, animations: {
      self.refreshButton.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
    }) { (complete) in
      UIView.animate(withDuration: 0.3) {
        self.refreshButton.transform = .identity
      }
    }
  }
  
  @objc func restartGame() {
    for row in 0...2 {
      for col in 0...2 {
        boardClickableCompartments[row][col].isUserInteractionEnabled = true
      }
    }
    for symbol in symbols {
      symbol.removeFromSuperview()
    }
    symbols.removeAll()
    board = [["","",""], ["","",""], ["","",""]]
    isPlayer1Turn = true
    turn = 0
    gameLoop()
  }
  
  @objc func goToMainMenuVC() {
    self.dismiss(animated: false, completion: nil)
  }
  
  
  
  // GADBannerViewDelegates
  /// Tells the delegate an ad request loaded an ad.
  func adViewDidReceiveAd(_ bannerView: GADBannerView) {
    bannerView.alpha = 0
    UIView.animate(withDuration: 1) {
      bannerView.alpha = 1
    }
  }

  /// Tells the delegate an ad request failed.
  func adView(_ bannerView: GADBannerView,
      didFailToReceiveAdWithError error: GADRequestError) {
    print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
  }

  /// Tells the delegate that a full-screen view will be presented in response
  /// to the user clicking on an ad.
  func adViewWillPresentScreen(_ bannerView: GADBannerView) {
    print("adViewWillPresentScreen")
  }

  /// Tells the delegate that the full-screen view will be dismissed.
  func adViewWillDismissScreen(_ bannerView: GADBannerView) {
    print("adViewWillDismissScreen")
  }

  /// Tells the delegate that the full-screen view has been dismissed.
  func adViewDidDismissScreen(_ bannerView: GADBannerView) {
    print("adViewDidDismissScreen")
  }

  /// Tells the delegate that a user click will open another app (such as
  /// the App Store), backgrounding the current app.
  func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
    print("adViewWillLeaveApplication")
  }
}

