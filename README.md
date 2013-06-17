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

Also note that you **may not** request the same attribute both in the `required` and `optional` fields, otherwise an error will be raised.


<table>
<tr><th>Attribute</th><th>Identifier</th></tr>
<tr><td>:name</td><td>http://axschema.org/namePerson</td></tr>
<tr><td>:nickname</td><td>http://axschema.org/namePerson/friendly</td></tr>
<tr><td>:first_name</td><td>http://axschema.org/namePerson/first</td></tr>
<tr><td>:last_name</td><td>http://axschema.org/namePerson/last</td></tr>
<tr><td>:company_name</td><td>http://axschema.org/company/name</td></tr>
<tr><td>:street</td><td>http://axschema.org/contact/postalAddress/home</td></tr>
<tr><td>:street2</td><td>http://axschema.org/contact/postalAddressAdditional/home</td></tr>
<tr><td>:street3</td><td>http://specs.nic.cz/attr/addr/main/street3</td></tr>
<tr><td>:city</td><td>http://axschema.org/contact/city/home</td></tr>
<tr><td>:state</td><td>http://axschema.org/contact/state/home</td></tr>
<tr><td>:country</td><td>http://axschema.org/contact/country/home</td></tr>
<tr><td>:postal_code</td><td>http://axschema.org/contact/postalCode/home</td></tr>
<tr><td>:billing_street</td><td>http://specs.nic.cz/attr/addr/bill/street</td></tr>
<tr><td>:billing_street2</td><td>http://specs.nic.cz/attr/addr/bill/street2</td></tr>
<tr><td>:billing_street3</td><td>http://specs.nic.cz/attr/addr/bill/street3</td></tr>
<tr><td>:billing_city</td><td>http://specs.nic.cz/attr/addr/bill/city</td></tr>
<tr><td>:billing_state</td><td>http://specs.nic.cz/attr/addr/bill/sp</td></tr>
<tr><td>:billing_country</td><td>http://specs.nic.cz/attr/addr/bill/cc</td></tr>
<tr><td>:billing_postal_code</td><td>http://specs.nic.cz/attr/addr/bill/pc</td></tr>
<tr><td>:shipping_street</td><td>http://specs.nic.cz/attr/addr/ship/street</td></tr>
<tr><td>:shipping_street2</td><td>http://specs.nic.cz/attr/addr/ship/street2</td></tr>
<tr><td>:shipping_street3</td><td>http://specs.nic.cz/attr/addr/ship/street3</td></tr>
<tr><td>:shipping_city</td><td>http://specs.nic.cz/attr/addr/ship/city</td></tr>
<tr><td>:shipping_state</td><td>http://specs.nic.cz/attr/addr/ship/sp</td></tr>
<tr><td>:shipping_country</td><td>http://specs.nic.cz/attr/addr/ship/cc</td></tr>
<tr><td>:shipping_postal_code</td><td>http://specs.nic.cz/attr/addr/ship/pc</td></tr>
<tr><td>:mailing_street</td><td>http://specs.nic.cz/attr/addr/mail/street</td></tr>
<tr><td>:mailing_street2</td><td>http://specs.nic.cz/attr/addr/mail/street2</td></tr>
<tr><td>:mailing_street3</td><td>http://specs.nic.cz/attr/addr/mail/street3</td></tr>
<tr><td>:mailing_city</td><td>http://specs.nic.cz/attr/addr/mail/city</td></tr>
<tr><td>:mailing_state</td><td>http://specs.nic.cz/attr/addr/mail/sp</td></tr>
<tr><td>:mailing_country</td><td>http://specs.nic.cz/attr/addr/mail/cc</td></tr>
<tr><td>:mailing_postal_code</td><td>http://specs.nic.cz/attr/addr/mail/pc</td></tr>
<tr><td>:phone</td><td>http://axschema.org/contact/phone/default</td></tr>
<tr><td>:phone_home</td><td>http://axschema.org/contact/phone/home</td></tr>
<tr><td>:phone_business</td><td>http://axschema.org/contact/phone/business</td></tr>
<tr><td>:phone_cell</td><td>http://axschema.org/contact/phone/cell</td></tr>
<tr><td>:phone_fax</td><td>http://axschema.org/contact/phone/fax</td></tr>
<tr><td>:email</td><td>http://axschema.org/contact/email</td></tr>
<tr><td>:email_notify</td><td>http://specs.nic.cz/attr/email/notify</td></tr>
<tr><td>:email_other</td><td>http://specs.nic.cz/attr/email/next</td></tr>
<tr><td>:website</td><td>http://axschema.org/contact/web/default</td></tr>
<tr><td>:blog</td><td>http://axschema.org/contact/web/blog</td></tr>
<tr><td>:personal_url</td><td>http://specs.nic.cz/attr/url/personal</td></tr>
<tr><td>:work_url</td><td>http://specs.nic.cz/attr/url/work</td></tr>
<tr><td>:rss</td><td>http://specs.nic.cz/attr/url/rss</td></tr>
<tr><td>:facebook</td><td>http://specs.nic.cz/attr/url/facebook</td></tr>
<tr><td>:twitter</td><td>http://specs.nic.cz/attr/url/twitter</td></tr>
<tr><td>:linkedin</td><td>http://specs.nic.cz/attr/url/linkedin</td></tr>
<tr><td>:icq</td><td>http://axschema.org/contact/IM/ICQ</td></tr>
<tr><td>:jabber</td><td>http://axschema.org/contact/IM/Jabber</td></tr>
<tr><td>:skype</td><td>http://axschema.org/contact/IM/Skype</td></tr>
<tr><td>:gtalk</td><td>http://specs.nic.cz/attr/im/google_talk</td></tr>
<tr><td>:live_id</td><td>http://specs.nic.cz/attr/im/windows_live</td></tr>
<tr><td>:vat_id</td><td>http://specs.nic.cz/attr/contact/ident/vat_id</td></tr>
<tr><td>:vat</td><td>http://specs.nic.cz/attr/contact/vat</td></tr>
<tr><td>:id_card</td><td>http://specs.nic.cz/attr/contact/ident/card</td></tr>
<tr><td>:passport</td><td>http://specs.nic.cz/attr/contact/ident/pass</td></tr>
<tr><td>:ssn</td><td>http://specs.nic.cz/attr/contact/ident/ssn</td></tr>
<tr><td>:student</td><td>http://specs.nic.cz/attr/contact/student</td></tr>
<tr><td>:valid</td><td>http://specs.nic.cz/attr/contact/valid</td></tr>
<tr><td>:status</td><td>http://specs.nic.cz/attr/contact/status</td></tr>
<tr><td>:adult</td><td>http://specs.nic.cz/attr/contact/adult</td></tr>
<tr><td>:image</td><td>http://specs.nic.cz/attr/contact/image</td></tr>
</table>

## License

MIT License