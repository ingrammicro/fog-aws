require 'fog/aws/models/compute/vpn_gateway'

module Fog
  module AWS
    class Compute
      class VpnGateways < Fog::Collection
        attribute :filters

        model Fog::Compute::AWS::VpnGateway

        # Creates a new VPN gateway
        #
        # AWS.vpn_gateways.new
        #
        # ==== Returns
        #
        # Returns the details of the new VPN gateway
        #
        #>> AWS.vpn_gateways.new(type: "ipsec.1", options)
        #    <Fog::Compute::AWS::VpnGateway
        #      vpn_gateway_id="vgw-11223344",
        #      amazon_side_asn=65001,
        #      attachments=[],
        #      state="available"
        #      tag_set={},
        #      type="ipsec.1"
        #    >
        #

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        # Returns an array of all VPN gateways that have been created
        #
        # AWS.vpn_gateways.all
        #
        # ==== Returns
        #
        # Returns an array of all VPN gateways
        #
        #>> AWS.network_interfaves.all
        #  <Fog::AWS::Compute::VpnGateways
        #    filters={}
        #    [
        #      <Fog::Compute::AWS::VpnGateway
        #        vpn_gateway_id="vgw-11223344",
        #        amazon_side_asn=65001,
        #        attachments=[],
        #        state="available"
        #        tag_set={},
        #        type="ipsec.1"
        #      >
        #    ]
        #  >
        #

        def all(filters_arg = filters)
          filters = filters_arg
          data = service.describe_vpn_gateways(filters).body
          load(data['vpnGatewaySet'])
        end

        # Used to retrieve a VPN gateway
        # VPN gateway id is required to get any information
        #
        # You can run the following command to get the details:
        # AWS.vpn_gateways.get("vgw-11223344")
        #
        # ==== Returns
        #
        #>> AWS.VpnGateway.get("vgw-11223344")
        #  <Fog::AWS::Compute::VpnGateway
        #    vpn_gateway_id="vgw-11223344",
        #    amazon_side_asn=65001,
        #    attachments=[],
        #    state="available"
        #    tag_set={},
        #    type="ipsec.1"
        #  >
        #

        def get(vpn_gateway_id)
          if vpn_gateway_id
            self.class.new(:service => service).all('vpn-gateway-id' => vpn_gateway_id).first
          end
        end
      end
    end
  end
end
