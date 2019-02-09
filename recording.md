# Recording audio notification

> This specification is currently being experimented.

[XEP-0085: Chat State Notifications](https://xmpp.org/extensions/xep-0085.html) provides a way for notifying a contact when you're composing a message.
It might be nice to let your buddy know whether you are composing a text message or an audio message.

In Kontalk, you add the standard composing node plus a custom audio recording node.

```xml
<message type='chat' from='alice@beta.kontalk.net/home' to='bob@beta.kontalk.net'>
  <composing xmlns='http://jabber.org/protocol/chatstates'/>
  <recording xmlns='http://kontalk.org/extensions/message#chatstates'/>
</message>
```
