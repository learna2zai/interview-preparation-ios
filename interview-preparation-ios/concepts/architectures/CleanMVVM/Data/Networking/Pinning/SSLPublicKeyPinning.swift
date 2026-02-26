//
//  SSLPublicKeyPinning.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 24/02/26.
//

import Foundation
import CryptoKit

final class SSLPublicKeyPinning: NSObject, URLSessionDataDelegate {
    
    private let pinnedHashes: Set<String> = [
        "GU4mANIqbRhsc46KdzcRcCGxmrrntf/lpIJ8T0cefL8=", // current
        "k+swi1D7Mu27FDJ9DAfns27/YipZz5s7BezuYsaXM/s=" // backup
    ]
    
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didReceive challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
                let serverTrust = challenge.protectionSpace.serverTrust else {
            return (.performDefaultHandling, nil)
        }
        
        guard SecTrustEvaluateWithError(serverTrust, nil),
              SecTrustGetCertificateCount(serverTrust) > 0,
                let certificateChain = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate] else {
            return (.cancelAuthenticationChallenge, nil)
        }
        
        for certificate in certificateChain {
            guard let publicKey = SecCertificateCopyKey(certificate),
                  let publicKeyData = SecKeyCopyExternalRepresentation(publicKey, nil) as Data? else {
                return (.cancelAuthenticationChallenge, nil)
            }
            
            let base64String = sha256(publicKeyData).base64EncodedString()
            
            if pinnedHashes.contains(base64String) {
                return (.useCredential, URLCredential(trust: serverTrust))
            }
        }

        return (.cancelAuthenticationChallenge, nil)
    }
    
    private func sha256(_ data: Data) -> Data {
        let digest = SHA256.hash(data: data)
        return Data(digest)
    }
}
