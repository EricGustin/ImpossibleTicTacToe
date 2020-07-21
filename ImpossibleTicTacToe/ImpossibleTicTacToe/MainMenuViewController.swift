//
//  MainMenuViewController.swift
//  ImpossibleTicTacToe
//
//  Created by Eric Gustin on 7/20/20.
//  Copyright © 2020 Eric Gustin. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MainMenuViewController: UIViewController, GADBannerViewDelegate {
  
  private var bannerView: GADBannerView!
  
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
    
    bannerView = GADBannerView(adSize: kGADAdSizeBanner)
    bannerView.adUnitID = "ca-app-pub-2778876616385267~9977005404"
    bannerView.rootViewController = self
    bannerView.load(GADRequest())
    bannerView.delegate = self
    bannerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(bannerView)
    bannerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    bannerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
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
