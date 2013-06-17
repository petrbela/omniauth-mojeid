require 'omniauth'
require 'omniauth-openid'
require 'rack/openid'
require 'openid/store/memory'
require 'attributes'

module OmniAuth
  module Strategies
    # OmniAuth strategy for connecting via MojeID.
    class MojeID < OmniAuth::Strategies::OpenID
      include OmniAuth::Strategy
      include MojeIDAttributes

      option :name, :mojeid
      option :required, [:email, :name, :first_name, :last_name]
      option :optional, [:nickname, :street, :city, :postal_code, :country]
      option :store, ::OpenID::Store::Memory.new
      option :identifier, 'https://mojeid.cz/endpoint/'
      # option :identifier_param, 'mojeid_url'

      # Called by omniauth when /auth/mojeid is opened.
      def request_phase
        openid = Rack::OpenID.new(dummy_app, options[:store])
        response = openid.call(env)
        case env['rack.openid.response']
        when Rack::OpenID::MissingResponse, Rack::OpenID::TimeoutResponse
          fail!(:connection_failed)
        else
          response
        end
      end

      uid { openid_response.display_identifier }

      info do
        sreg_user_info.merge(ax_user_info)
      end

      extra do
        { 'response' => openid_response }
      end


      private

      # Simple app that builds the request.
      def dummy_app
        lambda{|env| [401, {"WWW-Authenticate" => Rack::OpenID.build_header(
          :identifier => identifier,
          :return_to => callback_url,
          :required => options.required.map { |att| MOJE_ID[att] || att },
          :optional => options.optional.map { |att| MOJE_ID[att] || att },
          :method => 'post'
        )}, []]}
      end

      # Extract SReg attributes.
      # http://openid.net/specs/openid-simple-registration-extension-1_0.html
      def sreg_user_info
        sreg = ::OpenID::SReg::Response.from_success_response(openid_response)
        return {} unless sreg
        attrs = %w{fullname nickname dob email gender postcode country language timezone}
        Hash[
          attrs.map { |att| [att, sreg[att]] }
        ].reject{|k,v| v.nil? || v == ''}
      end

      # Extract all available user user profile attributes.
      # https://www.mojeid.cz/files/mojeid/mojeid_technicky.pdf
      def ax_user_info
        ax = ::OpenID::AX::FetchResponse.from_success_response(openid_response)
        return {} unless ax
        Hash[
          MOJE_ID.map { |key,att| [key,ax.get_single(att)] }
        ].reject{|k,v| v.nil? || v == ''}
      end
    end
  end
end

OmniAuth.config.add_camelization 'mojeid', 'MojeID'
OmniAuth.config.add_camelization 'Mojeid', 'MojeID'
