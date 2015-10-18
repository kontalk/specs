# File upload

This extension is actually just a support to "guide" clients into choosing an appropriate file hosting service to upload message attachments.

**This extension is far from complete and far from being useful outside of Kontalk specific usage. It needs a lot more work and there are also some security concerns that need to be addressed.**

Servers can advertise this feature during [service discovery](http://xmpp.org/extensions/xep-0030.html).

```xml
<iq from='example.com' type='result' id='H-1' to='alice@example.com'>
  <query xmlns='http://jabber.org/protocol/disco#info'>
    ...
    <feature var='http://kontalk.org/extensions/message#upload'/>
  </query>
</iq>
```

Client then requests info about that.

```xml
<iq id='H-2' to='example.com' type='get'>
  <query xmlns='http://jabber.org/protocol/disco#items' node='http://kontalk.org/extensions/message#upload'/>
</iq>
```

Let's say this server supports the Kontalk dropbox service only.

```xml
<iq from='example.com' type='result' id='H-2' to='alice@example.com'>
  <query xmlns='http://jabber.org/protocol/disco#items' node='http://kontalk.org/extensions/message#upload'>
    <item node='kontalkbox' jid='kontalk.net' name='Kontalk dropbox service'/>
  </query>
</iq>
```

And client again wants to know more:

```xml
<iq id='H-3' to='example.com' type='get'>
  <upload xmlns='http://kontalk.org/extensions/message#upload' node='kontalkbox'/>
</iq>
```

Server replies with information about the service. It actually depends on the service.

```xml
<iq from='example.com' type='result' id='H-3' to='alice@example.com'>
  <upload xmlns='http://kontalk.org/extensions/message#upload' node='kontalkbox'>
    <uri>http://prime.kontalk.net:5280/upload</uri>
  </upload>
</iq>
```
