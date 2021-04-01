//
//  ViewController.swift
//  Animation-Practice
//
//  Created by Shinichiro Kudo on 2021/03/31.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animView1: UIView! {
        didSet {
            // UITapGestureRecognizerはタップを認識するためのクラス
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapAnimView1))
            animView1.addGestureRecognizer(tap)
        }
    }
    
    @IBOutlet weak var animView2: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapAnimview2))
            animView2.addGestureRecognizer(tap)
        }
    }
    
    @IBOutlet weak var animView3: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapAnimview3))
            animView3.addGestureRecognizer(tap)
        }
    }
    
    
    // UIView.animateのメソッドの中身はこのようになっている
    // (withDuration: TimeInterval, animations: () -> Void, completion: ((Bool) -> Void)?)
 
    // ①見本のコード
    @objc func tapAnimView1() {
      //0.1sec アニメーション
      UIView.animate(withDuration: 0.1, animations: {
        self.animView1.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
      }) { (_) in //アニメーションが終わったcompletion
        //0.1sec アニメーション
        UIView.animate(withDuration: 0.1, animations: {
          self.animView1.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        }) { (_) in //アニメーションが終わったcompletion
          //0.1sec アニメーション
          UIView.animate(withDuration: 0.1, animations: {
            self.animView1.transform = .identity
          })
        }
      }
    }
    
    // Xcodeのサジェストに従うとこうなる
    // ②クロージャの理解を深めるために、違う書き方をした
    @objc func tapAnimview2() {
        UIView.animate(withDuration: 0.1) {
            self.animView2.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        } completion: { (Bool) in
            // アニメーションが終わったcompletion
            UIView.animate(withDuration: 0.1) {
                self.animView2.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            } completion: { (Bool) in
                // アニメーションが終わったcompletion
                UIView.animate(withDuration: 0.1, animations: {
                    self.animView2.transform = .identity
                }, completion: nil)
            }
        }
    }

    
    // ③さらに省略しない書き方をしてみた
    
    // １回目のanimations
    func animationClosure1() -> Void {
        self.animView3.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    }
    // ２回目のanimations
    func animationClosure2() -> Void {
        self.animView3.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    // ３回目のanimations
    func animationClosure3() -> Void {
        self.animView3.transform = .identity
    }
    // １回目のcompletion
    func completion1() -> Void {
        afterAciton()
    }
    // ２回目のcompletion
    func completion2() -> Void {
        finishAction()
    }
    
    @objc func tapAnimview3() {
        UIView.animate(withDuration: 0.1, animations: { self.animationClosure1() }, completion: { (Bool) -> Void in self.completion1() } )
    }

    func afterAciton() {
        UIView.animate(withDuration: 0.1, animations: { self.animationClosure2() }, completion: { (Bool) -> Void in self.completion2() } )
    }
    
    func finishAction() {
        UIView.animate(withDuration: 0.1, animations: { self.animationClosure3() }, completion: nil)
    }
    
    
}
