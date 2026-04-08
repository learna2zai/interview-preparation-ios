## SSL Pininng

Clean, minimal, production-style examples of both certificate pinning and public key pinning in Swift using URLSessionDelegate

**1️⃣ Certificate pinning (pin the exact server cert)**

What it does:
Compares the server’s certificate bytes to a local .cer file bundled in your app.

 - Pros: Very strong
 - Cons: Breaks when the cert is renewed

**2️⃣ Public key pinning (recommended in most apps)**

What it does:
Pins the public key hash, not the full certificate.

 - Pros: Survives cert renewal (as long as the key stays the same)
 - Cons: Slightly more code

### 1️⃣ Multiple pins + key rotation (production-ready pattern)
Why multiple pins matter

* If you ship only one pin and that key is ever rotated, your app bricks network access until users update.

**Best practice:**

 - ✅ Current key
 - ✅ Backup / next key(Optional) Intermediate CA key

```swift
    /// Base64(SHA256(public key))
    /// Include current + backup keys
    private let pinnedKeyHashes: Set<String> = [
        "k3k7u0pZQ+J6p9k8vL8FJXy5RzXkN8VqY2Y0Xxk4k9M=", // current
        "F9d8X2A1PzvLwM8kQK1nKZpZx2c3xP8Hk0s7Q9VJwE="  // backup
    ]
```

### 2️⃣ Extract public key hash using OpenSSL

This is the part everyone messes up at least once 😄
What you want is:

> Base64(SHA256(SPKI))

### Step A: Get the certificate
```
openssl s_client -connect example.com:443 -servername example.com </dev/null \
| openssl x509 -outform PEM > cert.pem
```

### Step B: Extract the public key (SPKI)
```
openssl x509 -in cert.pem -pubkey -noout > pubkey.pem
```

### Step C: Convert to DER + hash
```
openssl pkey -pubin -in pubkey.pem -outform DER \
| openssl dgst -sha256 -binary \
| openssl base64
```

**Output will look like:**

`k3k7u0pZQ+J6p9k8vL8FJXy5RzXkN8VqY2Y0Xxk4k9M=`

✅ This is exactly what you paste into your app

If you’re targeting iOS 13 or newer, use CryptoKit. It’s safer and cleaner.

```swift
import CryptoKit

func sha256(_ data: Data) -> Data {
    let digest = SHA256.hash(data: data)
    return Data(digest)
}
```

<img width="1408" height="768" alt="SSLTLSPinning" src="https://github.com/user-attachments/assets/3f4ce787-a783-4d2d-ae35-3d2cca59807e" />

