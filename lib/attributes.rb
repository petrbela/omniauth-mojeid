# for more informations about attributes look at http://www.mojeid.cz/page/800/jak-zavest-mojeid-/

module MojeIDAttributes
  MOJE_ID = {
    :name       => 'http://axschema.org/namePerson',
    :nickname   => 'http://axschema.org/namePerson/friendly',
    :first_name => 'http://axschema.org/namePerson/first',
    :last_name  => 'http://axschema.org/namePerson/last',

    :company_name  => 'http://axschema.org/company/name',

    :street      => 'http://axschema.org/contact/postalAddress/home',
    :street2     => 'http://axschema.org/contact/postalAddressAdditional/home',
    :street3     => 'http://specs.nic.cz/attr/addr/main/street3',
    :city        => 'http://axschema.org/contact/city/home',
    :state       => 'http://axschema.org/contact/state/home',
    :country     => 'http://axschema.org/contact/country/home',
    :postal_code => 'http://axschema.org/contact/postalCode/home',

    :billing_street       => 'http://specs.nic.cz/attr/addr/bill/street',
    :billing_street2      => 'http://specs.nic.cz/attr/addr/bill/street2',
    :billing_street3      => 'http://specs.nic.cz/attr/addr/bill/street3',
    :billing_city         => 'http://specs.nic.cz/attr/addr/bill/city',
    :billing_state        => 'http://specs.nic.cz/attr/addr/bill/sp',
    :billing_country      => 'http://specs.nic.cz/attr/addr/bill/cc',
    :billing_postal_code  => 'http://specs.nic.cz/attr/addr/bill/pc',

    :shipping_street      => 'http://specs.nic.cz/attr/addr/ship/street',
    :shipping_street2     => 'http://specs.nic.cz/attr/addr/ship/street2',
    :shipping_street3     => 'http://specs.nic.cz/attr/addr/ship/street3',
    :shipping_city        => 'http://specs.nic.cz/attr/addr/ship/city',
    :shipping_state       => 'http://specs.nic.cz/attr/addr/ship/sp',
    :shipping_country     => 'http://specs.nic.cz/attr/addr/ship/cc',
    :shipping_postal_code => 'http://specs.nic.cz/attr/addr/ship/pc',

    :mailing_street       => 'http://specs.nic.cz/attr/addr/mail/street',
    :mailing_street2      => 'http://specs.nic.cz/attr/addr/mail/street2',
    :mailing_street3      => 'http://specs.nic.cz/attr/addr/mail/street3',
    :mailing_city         => 'http://specs.nic.cz/attr/addr/mail/city',
    :mailing_state        => 'http://specs.nic.cz/attr/addr/mail/sp',
    :mailing_country      => 'http://specs.nic.cz/attr/addr/mail/cc',
    :mailing_postal_code  => 'http://specs.nic.cz/attr/addr/mail/pc',

    :phone          => 'http://axschema.org/contact/phone/default',
    :phone_home     => 'http://axschema.org/contact/phone/home',
    :phone_business => 'http://axschema.org/contact/phone/business',
    :phone_cell     => 'http://axschema.org/contact/phone/cell',
    :phone_fax      => 'http://axschema.org/contact/phone/fax',

    :email        => 'http://axschema.org/contact/email',
    :email_notify => 'http://specs.nic.cz/attr/email/notify',
    :email_other  => 'http://specs.nic.cz/attr/email/next',

    :website      => 'http://axschema.org/contact/web/default',
    :blog         => 'http://axschema.org/contact/web/blog',
    :personal_url => 'http://specs.nic.cz/attr/url/personal',
    :work_url     => 'http://specs.nic.cz/attr/url/work',
    :rss          => 'http://specs.nic.cz/attr/url/rss',
    :facebook     => 'http://specs.nic.cz/attr/url/facebook',
    :twitter      => 'http://specs.nic.cz/attr/url/twitter',
    :linkedin     => 'http://specs.nic.cz/attr/url/linkedin',

    :icq      => 'http://axschema.org/contact/IM/ICQ',
    :jabber   => 'http://axschema.org/contact/IM/Jabber',
    :skype    => 'http://axschema.org/contact/IM/Skype',
    :gtalk    => 'http://specs.nic.cz/attr/im/google_talk',
    :live_id  => 'http://specs.nic.cz/attr/im/windows_live',

    :vat_id        => 'http://specs.nic.cz/attr/contact/ident/vat_id',
    :vat           => 'http://specs.nic.cz/attr/contact/vat',

    :id_card  => 'http://specs.nic.cz/attr/contact/ident/card',
    :passport => 'http://specs.nic.cz/attr/contact/ident/pass',
    :ssn      => 'http://specs.nic.cz/attr/contact/ident/ssn',
    :student  => 'http://specs.nic.cz/attr/contact/student',
    :valid    => 'http://specs.nic.cz/attr/contact/valid',
    :status   => 'http://specs.nic.cz/attr/contact/status',
    :adult    => 'http://specs.nic.cz/attr/contact/adult',
    :image    => 'http://specs.nic.cz/attr/contact/image'
  }
end
