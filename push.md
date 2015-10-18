# Push notifications capability

**This extension will be probably replaced by a new XEP being defined in these days. Please refer to the relevant [mailing list discussion](http://mail.jabber.org/pipermail/standards/2014-January/028482.html).**

Servers can advertise this feature during [service discovery](http://xmpp.org/extensions/xep-0030.html).

```xml
<iq from='example.com' type='result' id='H-1' to='alice@example.com'>
  <query xmlns='http://jabber.org/protocol/disco#info'>
    ...
    <feature var='http://kontalk.org/extensions/presence#push'/>
  </query>
</iq>

```

When clients want to know more about the service, server replies with supported push notifications providers.

```xml
<iq id='H-2' to='example.com' type='get'>
  <query xmlns='http://jabber.org/protocol/disco#items' node='http://kontalk.org/extensions/presence#push'/>
</iq>
```

```xml
<iq from='example.com' type='result' id='H-2' to='alice@example.com'>
  <query xmlns='http://jabber.org/protocol/disco#items' node='http://www.kontalk.org/extensions/presence#push'>
    <item node='SENDER-ID' jid='gcm.push.kontalk.net' name='Google Cloud Messaging push notifications'/>
  </query>
</iq>
```

In this case, the node attribute contains the GCM sender ID that clients must use in order to obtain a registration ID.

After registering with Google Cloud Messaging, client must register with the push component to advertise its registration ID.

```xml
<iq to='push@example.com' type='set'>
  <register xmlns='http://kontalk.org/extensions/presence#push' provider='gcm'>REGISTRATION-ID</register>
</iq>
```

Currently, only GCM is supported.
