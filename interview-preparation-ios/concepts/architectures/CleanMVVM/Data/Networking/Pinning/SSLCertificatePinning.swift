//
//  SSLCertificatePinning.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 24/02/26.
//

import Foundation

final class SSLCertificatePinning: NSObject, URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
                let serverTrust = challenge.protectionSpace.serverTrust else {
            return (.performDefaultHandling, nil)
        }

        guard let path = Bundle.main.url(forResource: "typicode.com", withExtension: "der"),
                let pinnedCertificateData = try? Data(contentsOf: path) else {
            return (.cancelAuthenticationChallenge, nil)
        }
        
        let pinnedCertificateBase64String = pinnedCertificateData.base64EncodedString()
        
        guard SecTrustEvaluateWithError(serverTrust, nil),
                SecTrustGetCertificateCount(serverTrust) > 0,
                let certificateChain = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate] else {
            return (.cancelAuthenticationChallenge, nil)
        }
        
        for certificate in certificateChain {
            let certificateData = SecCertificateCopyData(certificate) as Data
            let certificateBase64String = certificateData.base64EncodedString()
            
            if certificateBase64String == pinnedCertificateBase64String {
                return (.useCredential, URLCredential(trust: serverTrust))
            }
        }
        
        return (.cancelAuthenticationChallenge, nil)
    }
}
