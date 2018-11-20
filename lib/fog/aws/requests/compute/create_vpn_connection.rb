module Fog
  module AWS
    class Compute
      class Real
        require 'fog/aws/parsers/compute/create_vpn_connection'

        # Creates an VpnConnection (= virtual private connection)
        #
        # ==== Parameters
        # * customer_gateway_id<~String> - The ID of the customer gateway.
        # * vpn_gateway_id<~String> - The ID of the virtual private gateway.
        # * type<~String> - The type of VPN connection the virtual private connection supports (ipsec.1).
        # * options<~Hash>: 
        #     'Options.StaticRoutesOnly'<~Boolean> - Whether the VPN connection uses static routes only.
        #     'Options.TunnelOptions.N.PreSharedKey'<~String> The pre-shared key (PSK) to establish initial authentication.
        #     'Options.TunnelOptions.N.TunnelInsideCidr'<~String> The range of inside IP addresses for the tunnel.
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - Id of request
        # * 'vpnConnection'<~Hash>:
        # *   'category'<~String> - Category of the VPN conntection.
        # *   'customerGatewayConfiguration'<~String> - Configuration information for the VPN connection's customer gateway (XML).
        # *   'customerGatewayId<~String> - The ID of the customer gateway.
        # *   'options'<~Hash> - Options for the VPN connection.
        # *     'staticRoutesOnly'<~Boolean> - Whether the VPN connection uses static routes only.
        # *   'routes' <~Array>:
        # *     'destinationCidrBlock'<~String> - The CIDR block associated with the local subnet of the customer data center.
        # *     'source'<~String> - Indicates how the routes were provided.
        # *     'state'<~String> - The current state of the static route.
        # *   'state'<~String> - The state of the VPN connection
        # *   'tagSet'<~Array>: Tags assigned to the resource.
        # *     'key'<~String> - Tag's key
        # *     'value'<~String> - Tag's value
        # *   'type'<~String> - The type of the VPN connection.
        # *   'vgwTelemetry' <~Array>:
        # *     'acceptedRouteCount'<~Integer> - The number of accepted routes.
        # *     'lastStatusChange'<~String> - Date and time of last status change.
        # *     'outsideIpAddress'<~String> - Internet-routable IP address of the virtual private gateway's outside interface.
        # *     'status'<~String> - The status of the VPN tunnel
        # *     'statusMessage'<~String> - If an error occurs, description of the error.
        # *   'vpnConnectionId'<~String> - The ID of the connection
        # *   'vpnGatewayId'<~String> - The ID of the virtual private gateway.
        #
        # {Amazon API Reference}[http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVpnConnection.html]
        def create_vpn_connection(customer_gateway_id, vpn_gateway_id, type, options = {})
          request({
            'Action'            => 'CreateVpnConnection',
            'CustomerGatewayId' => customer_gateway_id,
            'VpnGatewayId'      => vpn_gateway_id,
            'Type'              => type,
            :parser             => Fog::Parsers::AWS::Compute::CreateVpnConnection.new
          }.merge!(options))
        end
      end

      class Mock
        def create_vpn_connection(customer_gateway_id, vpn_gateway_id, type, options = {})
          raise "Not yet implemented!"
        end
      end
    end
  end
end
