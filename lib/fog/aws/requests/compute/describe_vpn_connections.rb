module Fog
  module AWS
    class Compute
      class Real
        require 'fog/aws/parsers/compute/describe_vpn_connections'

        # Describe all or specified vpn_connections
        #
        # ==== Parameters
        # * filters<~Hash> - List of filters to limit results with
        #
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - Id of request
        # * 'vpnConnectionSet'<~Array>:
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
        # {Amazon API Reference}[http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVpnConnections.html]
        def describe_vpn_connections(filters = {})
          unless filters.is_a?(Hash)
            Fog::Logger.warning("describe_vpn_connections with #{filters.class} param is deprecated, use vpn_connections('vpn-connection-id' => []) instead [light_black](#{caller.first})[/]")
            filters = {'vpn-connection-id' => [*filters]}
          end
          params = Fog::AWS.indexed_filters(filters)
          request({
            'Action' => 'DescribeVpnConnections',
            :idempotent => true,
            :parser => Fog::Parsers::Compute::AWS::DescribeVpnConnections.new
          }.merge!(params))
        end
      end

      class Mock
        def describe_vpn_connections(filters = {})
          raise "Not yet implemented!"
        end
      end
    end
  end
end
