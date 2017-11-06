# Phone number hash format

The phone number hash used in Kontalk JIDs are SHA-1 hashes generated from
[E.164](https://en.wikipedia.org/wiki/E.164) phone numbers.

Example phone number:

> +1 (555) 521-5554

The phone number to hash will be:

> +15555215554

The resulting hash will be:

> 4bdd4f929f3a1062253e4e496bafba0bdfb5db75

A JID for this number would be:

> 4bdd4f929f3a1062253e4e496bafba0bdfb5db75@beta.kontalk.net
