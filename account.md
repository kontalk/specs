# Account management

Account information and keys can be managed in many ways.

## Private key upload

In order to register another device, you can either transfer the personal key
manually via personal keypack zip file, or you can use the private key transfer
feature offered by the server.

This is a form submission example that can be used to request a server to store
a copy of your private key for a limited amount of time:

```xml
<iq id='iq-BCH123' type='set' to='prime.kontalk.net'>
  <query xmlns='jabber:iq:register'>
    <x xmlns='jabber:x:data' type='submit'>
      <field var='FORM_TYPE' type='hidden'>
        <value>http://kontalk.org/protocol/register#privatekey</value>
      </field>
      <field label='Private key' var='privatekey' type='text-single'>
        <value>[Base64-encoded private key]</value>
      </field>
    </x>
  </query>
</iq>
```

**IMPORTANT: the private key must be encrypted before it is sent to the server!**

If successful, the server will reply with an identification token that can later
be used from another device to retrieve the private key:

```xml
<iq id='iq-BCH123' type='result' from='prime.kontalk.net'>
  <query xmlns='jabber:iq:register'>
    <x xmlns='jabber:x:data' type='form'>
      <field var='FORM_TYPE' type='hidden'>
        <value>http://kontalk.org/protocol/register#privatekey</value>
      </field>
      <field label='Private key identification token' var='token' type='text-single'>
        <value>[private key token]</value>
      </field>
    </x>
  </query>
</iq>
```

## Private key retrieval

To request a previously stored private key, send a request to the server with
a private key token:

```xml
<iq id='iq-BCH321' type='get' to='prime.kontalk.net'>
  <query xmlns='jabber:iq:register'>
    <account xmlns='http://kontalk.org/protocol/register#account'>
      <privatekey>
        <token>[private key token]</token>
      </privatekey>
    </account>
  </query>
</iq>
```

If successful, the server will reply with the private key:

```xml
<iq id='iq-BCH321' type='result' from='prime.kontalk.net'>
  <query xmlns='jabber:iq:register'>
    <account xmlns='http://kontalk.org/protocol/register#account'>
      <privatekey>
        <private>[Base64-encoded private key]</private>
        <public>[Base64-encoded public key]</public>
      </privatekey>
    </account>
  </query>
</iq>
```

## Key update/rollover

A registration-like form is also used to register a new public key for the user,
in case the previous one has been compromised.

TODO
