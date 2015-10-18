# Public key presence subscription extension

When a user wants to subscribe to someone else's presence, it sends a presence with type subscribe as usual. If the server realizes that the requester has no permission to see the other user's presence, it forwards the subscription request, but not before having appended the requester's public key using a variant of [XEP-0189](http://xmpp.org/extensions/xep-0189.html).

```xml
<presence type='subscribe' from='alice@example.com' to='bob@example.com'>
  <pubkey xmlns='urn:xmpp:pubkey:2'>
    <key>[Base64-encoded public key block]</key>
    <print>[key fingerprint]</print>
  </pubkey>
</presence>
```
