# Group chat

> This page is under construction.

## Protocol overview
Instead of relying on the server to manage groups, we decided to let clients do the job. Every administrative task is carried out by clients. Group chat in Kontalk is more of a self-controlled group of people.  
All messages are multicasted to the other participants through [XEP-0033](http://xmpp.org/extensions/xep-0033.html). Although this is not strictly a part of the group extension protocol, it allows a client to reach every group member by sending only one message.
The `<group/>` extension must always include a group ID and the JID of the owner (i.e. who created the group).
All messages must be sent to the entity called `[hostname]` (TODO: service discovery will be used for this).

## Creating groups
A user who wants to initiate a group sends a group opening command with the type `create` to all participants by using a message stanza, indicating a group ID and optionally a group subject. The participants list is included in the address list by using XEP-0033 - which will be stripped out by the server - and also in the `<group/>` child.  

```xml
<message type='chat' from='david@beta.kontalk.net/home' to='beta.kontalk.net'>
  <addresses xmlns='http://jabber.org/protocol/address'>
    <address type='to' jid='alice@beta.kontalk.net'/>
    <address type='to' jid='bob@beta.kontalk.net'/>
  </addresses>
  <group xmlns='http://kontalk.org/extensions/message#group' id='GROUP-ID' owner='david@beta.kontalk.net' type='create'>
    <subject>Our great journey</subject>
    <member jid='alice@beta.kontalk.net'/>
    <member jid='bob@beta.kontalk.net'/>
  </group>
  <!-- an opening message can be sent using a body child, but it's entirely optional -->
  <body>Hey folks!</body>
</message>
```

## Sending messages
Any user that wants to send a message to the group can send a normal message stanza to all participants using XEP-0033 as usual. The group ID and owner must be included in every message.

```xml
<message type='chat' from='david@beta.kontalk.net/home' to='beta.kontalk.net'>
  <addresses xmlns='http://jabber.org/protocol/address'>
    <address type='to' jid='alice@beta.kontalk.net'/>
    <address type='to' jid='bob@beta.kontalk.net'/>
  </addresses>
  <group xmlns='http://kontalk.org/extensions/message#group' id='GROUP-ID' owner='david@beta.kontalk.net'/>
  <body>What is going on?</body>
</message>
```

## Modifying group settings

The group creator can change group settings by sending a group command with the type `set`.

### Adding users to the group

```xml
<message type='chat' from='david@beta.kontalk.net/home' to='beta.kontalk.net'>
  <addresses xmlns='http://jabber.org/protocol/address'>
    <address type='to' jid='alice@beta.kontalk.net'/>
    <address type='to' jid='bob@beta.kontalk.net'/>
    <!-- this is the new participant -->
    <address type='to' jid='charlie@beta.kontalk.net'/>
  </addresses>
  <group xmlns='http://kontalk.org/extensions/message#group' id='GROUP-ID' owner='david@beta.kontalk.net' type='set'>
    <!-- including subject and list of all members -->
    <subject>Our great journey</subject>
    <add jid='charlie@beta.kontalk.net'/>
    <member jid='alice@beta.kontalk.net'/>
    <member jid='bob@beta.kontalk.net'/>
  </group>
  <!-- optionally, a message can be included -->    
  <body>Welcome Charlie!</body>
</message>
```

### Removing users from the group

```xml
<message type='chat' from='david@beta.kontalk.net/home' to='beta.kontalk.net'>
  <addresses xmlns='http://jabber.org/protocol/address'>
    <address type='to' jid='alice@beta.kontalk.net'/>
    <address type='to' jid='bob@beta.kontalk.net'/>
    <address type='to' jid='charlie@beta.kontalk.net'/>
  </addresses>
  <group xmlns='http://kontalk.org/extensions/message#group' id='GROUP-ID' owner='david@beta.kontalk.net' type='set'>
    <remove jid='charlie@beta.kontalk.net'/>
  </group>
  <!-- optionally, a message can be included -->
  <body>Sorry Charlie, you're out.</body>
</message>
```

### Changing the group subject

```xml
<message type='chat' from='david@beta.kontalk.net/home' to='beta.kontalk.net'>
  <addresses xmlns='http://jabber.org/protocol/address'>
    <address type='to' jid='alice@beta.kontalk.net'/>
    <address type='to' jid='bob@beta.kontalk.net'/>
    <address type='to' jid='charlie@beta.kontalk.net'/>
  </addresses>
  <group xmlns='http://kontalk.org/extensions/message#group' id='GROUP-ID' owner='david@beta.kontalk.net' type='set'>
    <subject>Our journey continues</subject>
  </group>
  <!-- optionally, a message can be included -->    
  <body>Keep on rocking!</body>
</message>
```

## Leaving the group
If a user wants to leave a group, the user must send a part command:

```xml
<message type='chat' from='david@beta.kontalk.net/home' to='beta.kontalk.net'>
  <addresses xmlns='http://jabber.org/protocol/address'>
    <address type='to' jid='alice@beta.kontalk.net'/>
    <address type='to' jid='bob@beta.kontalk.net'/>
    <address type='to' jid='charlie@beta.kontalk.net'/>
  </addresses>
  <group xmlns='http://kontalk.org/extensions/message#group' id='GROUP-ID' owner='david@beta.kontalk.net'>
    <part/>
  </group>
  <!-- optionally a goodbye message can be included -->
  <body>Goodbye!</body>
</message>
```

When the other users receive this command, they should not consider the sender to be part of the group anymore and stop sending messages to that user.

## Security considerations
Because this protocol is completely controlled by clients, a client must be implemented to correctly interpret and carry out protocol commands in a secure way, filtering unsolicited or unwanted stanzas if necessary, including:

* Ignoring add/remove group commands from any user but the owner
* Ignoring any message stanza that has a group ID but a different owner than the one expected
* Discarding any messages from non-members

## Encryption
All group stanzas are encrypted using a multirecipient key as of OpenPGP specification. The only thing that must be kept in cleartext is the XEP-0033 address list, which must be read by the server so it can deliver the message to all users. However group ID and all other information can and should be encrypted.
