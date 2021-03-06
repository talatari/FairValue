//
//  SceneDelegate.swift
//  FairValue
//
//  Created by Tsaplin-SO on 29.08.2021.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    /*
    func test() {
        
        struct BookValue {
            var name: String?
        }
        
        struct BookRef {
            var name: String
        }
        
        class HolderValue {
//            var book: BookValue = BookValue(name: "Winney the pooh")
            var book: BookValue
            
//            init() {
//                self.book = BookValue(name: "Winney the pooh")
//            }
            
            init(book: BookValue) {
                self.book = book
            }
            
//            init(book: BookValue) -> HolderValue {
//                self = super.init()
//
//                self.book = book
//
//                return self
//            }
        }
        
        
        class Person {
            
            func takeOffGlasses() {
                // ...
            }
            
            func takeOnGlasses() {
                // ...
            }
            
            func cleanUpGlasses() {
                
                self.takeOffGlasses()
                
                // ...
                
                self.takeOnGlasses()
            }
            
        }
        
        
        let book = BookValue(name: "Test")
        
        
        //       self    FairValue.HolderValue    0x000060000382db60
        // bookHolder    FairValue.HolderValue    0x000060000382db60
        let bookHolder = HolderValue(book: book)
        
        
        //        self    FairValue.HolderValue    0x0000600003800240
        // bookHolder2    FairValue.HolderValue    0x0000600003800240
        let bookHolder2 = HolderValue(book: book)
//        bookHolder.book = book
        
        
        bookHolder.book.name = "Book in holder"
        
//        if (bookHolder.book != nil) {
//            bookHolder.book!.name = "Book in holder"
//        }
//
        
        class HolderRef {
            var book: BookRef
            
            init(book: BookRef) {
                self.book = book
            }
        }
    
    }
    */

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        //test()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

