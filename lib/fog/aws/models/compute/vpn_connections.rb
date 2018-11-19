require 'fog/aws/models/compute/vpn_connection'

module Fog
  module AWS
    class Compute
      class VpnConnections < Fog::Collection
        attribute :filters

        model Fog::Compute::AWS::VpnConnection

        # Creates a new VPN connection
        #
        # AWS.vpn_connections.new
        #
        # ==== Returns
        #
        # Returns the details of the new VPN connection
        #
        #>> AWS.vpn_connections.new(customer_gateway_id: "cgw-11223344", vpn_gateway_id: "vgw-11223344", type: "ipsec.1", options)
        #    <Fog::Compute::AWS::VpnConnection
        #     category<~String> - Category of the VPN conntection.
        #     customer_gateway_configuration<~String> - Configuration information for the VPN connection's customer gateway (XML).
        #     customer_gateway_id<~String> - The ID of the customer gateway.
        #     options<~Hash> - Options for the VPN connection.
        #      'staticRoutesOnly'<~Boolean> - Whether the VPN connection uses static routes only.
        #     routes<~Array>:
        #      'destinationCidrBlock'<~String> - The CIDR block associated with the local subnet of the customer data center.
        #      'source'<~String> - Indicates how the routes were provided.
        #      'state'<~String> - The current state of the static route.
        #     state<~String> - The state of the VPN connection
        #     tag_set<~Array>: Tags assigned to the resource.
        #      'key'<~String> - Tag's key
        #      'value'<~String> - Tag's value
        #     type<~String> - The type of the VPN connection.
        #     vgw_telemetry <~Array>:
        #      'acceptedRouteCount'<~Integer> - The number of accepted routes.
        #      'lastStatusChange'<~String> - Date and time of last status change.
        #      'outsideIpAddress'<~String> - Internet-routable IP address of the virtual private gateway's outside interface.
        #      'status'<~String> - The status of the VPN tunnel
        #      'statusMessage'<~String> - If an error occurs, description of the error.
        #     vpn_connection_id<~String> - The ID of the connection
        #     vpn_gateway_id<~String> - The ID of the virtual private gateway.
        #    >
        #

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        # Returns an array of all VPN connections that have been created
        #
        # AWS.vpn_connections.all
        #
        # ==== Returns
        #
        # Returns an array of all VPN connections
        #
        #>> AWS.network_interfaves.all
        #  <Fog::AWS::Compute::VpnConnections
        #    filters={}
        #    [
        #      <Fog::Compute::AWS::VpnConnection
        #        category<~String> - Category of the VPN conntection.
        #        customer_gateway_configuration<~String> - Configuration information for the VPN connection's customer gateway (XML).
        #        customer_gateway_id<~String> - The ID of the customer gateway.
        #        options<~Hash> - Options for the VPN connection.
        #         'staticRoutesOnly'<~Boolean> - Whether the VPN connection uses static routes only.
        #        routes<~Array>:
        #         'destinationCidrBlock'<~String> - The CIDR block associated with the local subnet of the customer data center.
        #         'source'<~String> - Indicates how the routes were provided.
        #         'state'<~String> - The current state of the static route.
        #        state<~String> - The state of the VPN connection
        #        tag_set<~Array>: Tags assigned to the resource.
        #         'key'<~String> - Tag's key
        #         'value'<~String> - Tag's value
        #        type<~String> - The type of the VPN connection.
        #        vgw_telemetry <~Array>:
        #         'acceptedRouteCount'<~Integer> - The number of accepted routes.
        #         'lastStatusChange'<~String> - Date and time of last status change.
        #         'outsideIpAddress'<~String> - Internet-routable IP address of the virtual private gateway's outside interface.
        #         'status'<~String> - The status of the VPN tunnel
        #         'statusMessage'<~String> - If an error occurs, description of the error.
        #        vpn_connection_id<~String> - The ID of the connection
        #        vpn_gateway_id<~String> - The ID of the virtual private gateway.
        #      >
        #    ]
        #  >
        #

        def all(filters_arg = filters)
          filters = filters_arg
          data = service.describe_vpn_connections(filters).body
          load(data['vpnConnectionSet'])
        end

        # Used to retrieve a VPN connection
        # VPN connection id is required to get any information
        #
        # You can run the following command to get the details:
        # AWS.vpn_connections.get("vgw-11223344")
        #
        # ==== Returns
        #
        #>> AWS.VpnConnection.get("vgw-11223344")
        #  <Fog::AWS::Compute::VpnConnection
        #  TODO  vpn_connection_id="vgw-11223344",
        #    amazon_side_asn=65001,
        #    attachments=[],
        #    state="available"
        #    tag_set={},
        #    type="ipsec.1"
        #  >
        #

        def get(vpn_connection_id)
          if vpn_connection_id
            self.class.new(:service => service).all('vpn-connection-id' => vpn_connection_id).first
          end
        end
      end
    end
  end
end
