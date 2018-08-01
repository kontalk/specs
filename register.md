# Kontalk in-band registration ([XEP-0077](http://xmpp.org/extensions/xep-0077.html))

This extension is used to register to the Kontalk service. It uses [XEP-0077: In-band registration](http://xmpp.org/extensions/xep-0077.html) with a few more form fields to include some stuff such as verification code, phone number and public key.

Registration capability is advertised in stream features with the XEP-0077 namespace.

```xml
<stream:features>
  <register xmlns="http://jabber.org/features/iq-register"/>
</stream:features>
```

The first step is requesting phone number verification.

```xml
<iq to='prime.kontalk.net' id='80zgA-18' type='set'>
  <query xmlns='jabber:iq:register'>
    <x xmlns='jabber:x:data' type='submit'>
      <field var='FORM_TYPE' type='hidden'>
        <value>jabber:iq:register</value>
      </field>
      <field label='Phone number' var='phone' type='text-single'>
        <value>+15555215554</value>
      </field>
    </x>
  </query>
</iq>
```

If the server finds another user account with the same number, it will return an error.

```xml
<iq id="80zgA-18" from="prime.kontalk.net" type="error">
  <query xmlns="jabber:iq:register">
    <x xmlns="jabber:x:data" type="submit">
      <field var="FORM_TYPE" type="hidden">
        <value>jabber:iq:register</value>
      </field>
      <field var="phone" type="text-single" label="Phone number">
        <value>+15555215554</value>
      </field>
    </x>
  </query>
  <error code="409" type="modify">
    <conflict xmlns="urn:ietf:params:xml:ns:xmpp-stanzas"/>
    <text xmlns="urn:ietf:params:xml:ns:xmpp-stanzas" xml:lang="en">Another user is registered with the same id.</text>
  </error>
</iq>
```

In that case, you can force registration by submitting the request again, this time with a `force` attribute.

```xml
<iq to='prime.kontalk.net' id='80zgA-22' type='set'>
  <query xmlns='jabber:iq:register'>
    <x xmlns='jabber:x:data' type='submit'>
      <field var='FORM_TYPE' type='hidden'>
        <value>jabber:iq:register</value>
      </field>
      <field label='Phone number' var='phone' type='text-single'>
        <value>+15555215554</value>
      </field>
      <field label='Force registration' var='force' type='boolean'>
        <value>true</value>
      </field>
    </x>
  </query>
</iq>
```

If successful, the server will reply with human-readable instructions and a challenge type.

```xml
<iq id="80zgA-22" from="prime.kontalk.net" type="result">
  <query xmlns="jabber:iq:register">
    <instructions>A SMS with a verification code will be sent to emulator emulator-5554.</instructions>
    <x xmlns="jabber:x:data" type="form">
      <field var="FORM_TYPE" type="hidden">
        <value>jabber:iq:register</value>
      </field>
      <field label="Sender ID" var="from" type="text-single">
        <value>12345</value>
      </field>
      <field label="Challenge type" var="challenge" type="text-single">
        <value>pin</value>
      </field>
    </x>
  </query>
</iq>
```

In the example above, you can see the server will send a SMS to the Android emulator named emulator-5554, using 12345 as the sender ID.
The SMS will contain a PIN code (hence the challenge type `pin`) that must be typed in by the user to confirm registration.

Supported challenge types are:

* **pin**: the user receives a PIN that must be typed in to confirm registration
* **missedcall**: the user receives a missed call from a random number. The user must type in some challenge about that number e.g. last 5 digits

For the next connection, the client must provide a client certificate signed with the user's PGP private key and embedded with the user's PGP public key.
This step is when the verification happens. The user provides the challenge code, either the PIN or the missing piece of the missed call number.

```xml
<iq to='prime.kontalk.net' id='80zgA-25' type='set'>
  <query xmlns='jabber:iq:register'>
    <x xmlns='jabber:x:data' type='submit'>
      <field var='FORM_TYPE' type='hidden'>
        <value>http://kontalk.org/protocol/register#code</value>
      </field>
      <field label='Validation code' var='code' type='text-single'>
        <value>839775</value>
      </field>
    </x>
  </query>
</iq>
```

If the verification is successful, the server replies with a signed public key that can be used to login.

```xml
<iq id="80zgA-25" from="prime.kontalk.net" type="result">
  <query xmlns="jabber:iq:register">
    <x xmlns="jabber:x:data" type="form">
      <field var="FORM_TYPE" type="hidden">
        <value>http://kontalk.org/protocol/register#code</value>
      </field>
      <field label="Signed public key" var="publickey" type="text-single">
        <value>[Base64-encoded public key]</value>
      </field>
    </x>
  </query>
</iq>
```

You can now close the stream and initiate a new connection with a new certificate embedding the signed public key.
