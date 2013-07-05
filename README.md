# OmniAuth::MojeID 

> [MojeID](http://www.mojeid.cz) authentication strategy.

OmniAuth::MojeID is an extension to [OmniAuth::OpenID](https://github.com/intridea/omniauth-openid) with some useful defaults and added attributes.

## Installation

    gem install omniauth-mojeid

## Configuration

### Rails 3 + Devise + OmniAuthable

Inside `devise.rb`, add a simple line:

```ruby
config.omniauth :mojeid
```

This will prompt the user for the default attributes. If you want to configure which attributes to obtain from the user, specify them in the `required` and `optional` fields.

```ruby    
config.omniauth :mojeid, :required => [:name, :email], :optional => [:city]
```

See full list of [profile attributes](#profile-attributes).

### Stand-Alone Example

Use the strategy as a middleware in your application:

```ruby
require 'omniauth-mojeid'

use Rack::Session::Cookie
use OmniAuth::Strategies::MojeID
```

### OmniAuth Builder

If MojeID is one of several authentication strategies, use the OmniAuth Builder:

```ruby
require 'omniauth-mojeid'

use OmniAuth::Builder do
  provider :mojeid
end
```

By default, the omniauth information during the response handling is stored in ruby-openid's Memory Store. To change this, override the `store` option:

```ruby
require 'omniauth-openid'
require 'openid/store/filesystem'

use OmniAuth::Builder do
  provider :mojeid, :store => OpenID::Store::Filesystem.new('/tmp')
end
```

## Authentization Verification

Create an xml file and make it available at `YOUR_URL/xrds.xml`. The file should contain this text (don't forget to replace YOUR_URL):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xrds:XRDS xmlns:xrds="xri://$xrds" xmlns="xri://$xrd*($v*2.0)">
   <XRD>
     <Service>
       <Type>http://specs.openid.net/auth/2.0/return_to</Type>
       <URI>***YOUR_URL***/auth/mojeid/callback</URI>
     </Service>
   </XRD>
</xrds:XRDS>
```

## Usage

Simply point users to `/auth/mojeid` which will redirect them to MojeID.cz website to prompt them for their profile information.

In the response callback at `/auth/mojeid/callback`, the attributes will become available in the `["omniauth.auth"]["info"]` hash. So, to print out user's email, use `["omniauth.auth"]["info"][:email]`.

To learn about the internals please read [the specification](https://www.mojeid.cz/files/mojeid/mojeid_technicky.pdf) (in Czech).


## Profile attributes

By default, mojeid asks user for the following profile attributes:

```ruby
:required => [:email, :name, :first_name, :last_name]
:optional => [:nickname, :street, :city, :postal_code, :country]
```

If you want to customize the information, use the attributes listed in the table below. 

You can also use the [Simple Reg](http://openid.net/specs/openid-simple-registration-extension-1_0.html) name (as a string) to name the attributes. (Though in my experience the mapping doesn't seem to be working well.)

```ruby
:required => ['email', 'fullname', :first_name, :last_name, 'dob']
```

Note that the user can decide if they share the information with you, so even if you request certain fields, they may be empty (`nil`).

Also note that you **may not** request the same attribute both in the `required` and `optional` fields otherwise an error will be raised.


| Attribute             | Identifier
| --------------------- | -------------------------------------------------
| :name                 | http://axschema.org/namePerson
| :nickname             | http://axschema.org/namePerson/friendly
| :first_name           | http://axschema.org/namePerson/first
| :last_name            | http://axschema.org/namePerson/last
| :company_name         | http://axschema.org/company/name
| :street               | http://axschema.org/contact/postalAddress/home
| :street2              | http://axschema.org/contact/postalAddressAdditional/home
| :street3              | http://specs.nic.cz/attr/addr/main/street3
| :city                 | http://axschema.org/contact/city/home
| :state                | http://axschema.org/contact/state/home
| :country              | http://axschema.org/contact/country/home
| :postal_code          | http://axschema.org/contact/postalCode/home
| :billing_street       | http://specs.nic.cz/attr/addr/bill/street
| :billing_street2      | http://specs.nic.cz/attr/addr/bill/street2
| :billing_street3      | http://specs.nic.cz/attr/addr/bill/street3
| :billing_city         | http://specs.nic.cz/attr/addr/bill/city
| :billing_state        | http://specs.nic.cz/attr/addr/bill/sp
| :billing_country      | http://specs.nic.cz/attr/addr/bill/cc
| :billing_postal_code  | http://specs.nic.cz/attr/addr/bill/pc
| :shipping_street      | http://specs.nic.cz/attr/addr/ship/street
| :shipping_street2     | http://specs.nic.cz/attr/addr/ship/street2
| :shipping_street3     | http://specs.nic.cz/attr/addr/ship/street3
| :shipping_city        | http://specs.nic.cz/attr/addr/ship/city
| :shipping_state       | http://specs.nic.cz/attr/addr/ship/sp
| :shipping_country     | http://specs.nic.cz/attr/addr/ship/cc
| :shipping_postal_code | http://specs.nic.cz/attr/addr/ship/pc
| :mailing_street       | http://specs.nic.cz/attr/addr/mail/street
| :mailing_street2      | http://specs.nic.cz/attr/addr/mail/street2
| :mailing_street3      | http://specs.nic.cz/attr/addr/mail/street3
| :mailing_city         | http://specs.nic.cz/attr/addr/mail/city
| :mailing_state        | http://specs.nic.cz/attr/addr/mail/sp
| :mailing_country      | http://specs.nic.cz/attr/addr/mail/cc
| :mailing_postal_code  | http://specs.nic.cz/attr/addr/mail/pc
| :phone                | http://axschema.org/contact/phone/default
| :phone_home           | http://axschema.org/contact/phone/home
| :phone_business       | http://axschema.org/contact/phone/business
| :phone_cell           | http://axschema.org/contact/phone/cell
| :phone_fax            | http://axschema.org/contact/phone/fax
| :email                | http://axschema.org/contact/email
| :email_notify         | http://specs.nic.cz/attr/email/notify
| :email_other          | http://specs.nic.cz/attr/email/next
| :website              | http://axschema.org/contact/web/default
| :blog                 | http://axschema.org/contact/web/blog
| :personal_url         | http://specs.nic.cz/attr/url/personal
| :work_url             | http://specs.nic.cz/attr/url/work
| :rss                  | http://specs.nic.cz/attr/url/rss
| :facebook             | http://specs.nic.cz/attr/url/facebook
| :twitter              | http://specs.nic.cz/attr/url/twitter
| :linkedin             | http://specs.nic.cz/attr/url/linkedin
| :icq                  | http://axschema.org/contact/IM/ICQ
| :jabber               | http://axschema.org/contact/IM/Jabber
| :skype                | http://axschema.org/contact/IM/Skype
| :gtalk                | http://specs.nic.cz/attr/im/google_talk
| :live_id              | http://specs.nic.cz/attr/im/windows_live
| :vat_id               | http://specs.nic.cz/attr/contact/ident/vat_id
| :vat                  | http://specs.nic.cz/attr/contact/vat
| :id_card              | http://specs.nic.cz/attr/contact/ident/card
| :passport             | http://specs.nic.cz/attr/contact/ident/pass
| :ssn                  | http://specs.nic.cz/attr/contact/ident/ssn
| :student              | http://specs.nic.cz/attr/contact/student
| :valid                | http://specs.nic.cz/attr/contact/valid
| :status               | http://specs.nic.cz/attr/contact/status
| :adult                | http://specs.nic.cz/attr/contact/adult
| :image                | http://specs.nic.cz/attr/contact/image


## License

MIT License