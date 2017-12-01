module Fog
  module Compute
    class AWS
      class Real
        require 'fog/aws/parsers/compute/basic'
        # Enables a virtual private gateway (VGW) to propagate routes to the specified route table.
        #
        # ==== Parameters
        # * vpn_gateway_id<~String> - The ID of the virtual private gateway.
        # * route_table_id<~String> - The ID of the route table.
        #
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - Id of request
        # * 'return'<~Boolean> - Returns true if the request succeeds.
        #
        # {Amazon API Reference}[http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVpnConnectionRoute.html]
        def enable_vgw_route_propagation(vpn_gateway_id, route_table_id)
          request(
            'Action'            => 'EnableVgwRoutePropagation',
            'GatewayId'         => vpn_gateway_id,
            'RouteTableId'      => route_table_id,
            :parser => Fog::Parsers::Compute::AWS::Basic.new
          )
        end
      end

      class Mock
        def enable_vgw_route_propagation(vpn_gateway_id, route_table_id)
          raise "Not yet implemented"
        end
      end
    end
  end
end
