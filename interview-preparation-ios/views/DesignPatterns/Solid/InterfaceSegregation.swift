//
//  InterfaceSegregation.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

struct InterfaceSegregation: SolidPrincipleProtocol {
    let title: String = "Interface Segregation"
    let description: String = "Interface segregation principle states that a software entity should not depend on methods of a type that it does not use."
    
    var problem: String = """
        // MARK: - Interface Segregation

        protocol SmartDevice {
            func makeCall()
            func sendEmail()
            func browseInternet()
            func takePicture()
        }

        class Phone: SmartDevice {
            func makeCall() {
                print("Make Call")
            }
            
            func sendEmail() {
                print("Send an email")
            }
            
            func browseInternet() {
                print("Browse an Internet")
            }
            
            func takePicture() {
                print("Take a Picture")
            }
        }

        class Watch: SmartDevice {
            func makeCall() {
                print("Make Call on Watch")
            }
            
            func sendEmail() {
                print("Send an email")
            }
            
            func browseInternet() { }
            
            func takePicture() { }
        }
        
        /// voilates IS
        """
    
    var resolution: String = """
        
        protocol Calling {
            func makeCall()
        }

        protocol Emailing {
            func sendEmail()
        }

        protocol Browsing {
            func browseInternet()
        }

        protocol Camera {
            func takePicture()
        }
        
        class SmartPhone: Calling, Emailing, Browsing, Camera {
            func makeCall() {
                print("Make Call")
            }
            
            func sendEmail() {
                print("Send an email")
            }
            
            func browseInternet() {
                print("Browse an Internet")
            }
            
            func takePicture() {
                print("Take a Picture")
            }
        }

        class SmartWatch: Calling, Emailing {
            func makeCall() {
                print("Make Call")
            }
            
            func sendEmail() {
                print("Send an email")
            }
        }
        """
}
