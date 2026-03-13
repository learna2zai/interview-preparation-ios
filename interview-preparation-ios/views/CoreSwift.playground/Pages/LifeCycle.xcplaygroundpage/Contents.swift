//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

// MARK: - Application LifeCycle

// States
// not running - application not launched or terminated
// inactive - application is running but not receving events
// active - application is running in foreground and receving events
// background - application runing in background
// suspended - application is in memory but not executing code

// all UIApplicationDelegate methods

class SomeApp: NSObject, UIApplicationDelegate {
    func applicationDidFinishLaunching(_ application: UIApplication) {
        //
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        //
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        //
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        //
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        //
    }
}

// MARK: - Scene Delegate

class SomeScene: NSObject, UISceneDelegate {
    
    func sceneDidDisconnect(_ scene: UIScene)
    {
        //
    }
    func sceneDidBecomeActive(_ scene: UIScene)
    {
        //
    }
    func sceneWillResignActive(_ scene: UIScene)
    {
        //
    }
    func sceneWillEnterForeground(_ scene: UIScene)
    {
        //
    }
    
    func sceneDidEnterBackground(_ scene: UIScene)
    {
        //
    }
}
// MARK: - View LifeCycle

// viewDidload()
// viewWillAppear
// viewDidAppear
// viewWillDisappear
// viewDidDisappear

class DemoViewController: UIViewController {
    
    init () {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        //        print(#function)
    }
    
    override func viewDidLoad() {
        //        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(#function)
    }
    
    override func viewWillLayoutSubviews() {
        print(#function)
    }
    
    override func viewDidLayoutSubviews() {
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print(#function)
    }
    
    deinit {
        print(#function)
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = DemoViewController()
PlaygroundPage.current.liveView = nil


//: [Next](@next)
