# Roster match

When you upgrade your contact list in Kontalk, you actually trigger this
procedure. The client builds a XML block with SHA1 hashes of all your contacts'
phone numbers and sends them to the server. The server than looks them up in the
whole network and returns matches.

## Service discovery

When requesting discovery items, the probe component will show up:

```xml
<iq type="result" to="alice@beta.kontalk.net/wonderland" id="41VKi-7" from="beta.kontalk.net">
  <query xmlns="http://jabber.org/protocol/disco#items">
    ...
    <item jid="probe@beta.kontalk.net" name="Kontalk probe engine"/>
    ...
  </query>
</iq>
```

## Request

When you want to initiate a roster match request, send it to the probe component with a list
of JIDs to be searched. You must send them with the domain part of the server you are
connected with, no matter to what server you think the user is connected.
The server will reply with correct domain parts.

```xml
<iq type="get" to="probe@beta.kontalk.net" id="N1">
  <query xmlns="http://kontalk.org/extensions/roster">
    <item jid="sha1_hash_of_bob@beta.kontalk.net"/>
    <item jid="sha1_hash_of_charlie@beta.kontalk.net"/>
    <item jid="sha1_hash_of_dave@beta.kontalk.net"/>
    ...
  </query>
</iq>
```

The server will look up the request JIDs on the network and reply with matches.

```xml
<iq type="result" to="alice@beta.kontalk.net/wonderland" from="probe@beta.kontalk.net" id="N1">
  <query xmlns="http://kontalk.org/extensions/roster">
    <item jid="sha1_hash_of_bob@prime.kontalk.net"/>
    <item jid="sha1_hash_of_dave@beta.kontalk.net"/>
    ...
  </query>
</iq>
```
