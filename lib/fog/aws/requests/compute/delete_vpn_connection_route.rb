module Fog
  module Compute
    class AWS
      class Real
        require 'fog/aws/parsers/compute/basic'
        # Deletes a static route associated with a VPN connection.
        #
        # ==== Parameters
        # * destination_cidr_block<~String> - The CIDR block associated with the local subnet of the customer network.
        # * vpn_connection_id<~String> - The ID of the VPN connection.
        #
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - Id of request
        # * 'return'<~Boolean> - Returns true if the request succeeds.
        #
        # {Amazon API Reference}[http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteVpnConnectionRoute.html]
        def delete_vpn_connection_route(destination_cidr_block, vpn_connection_id)
          request(
            'Action'                => 'DeleteVpnConnectionRoute',
            'DestinationCidrBlock'  => destination_cidr_block,
            'VpnConnectionId'       => vpn_connection_id,
            :parser => Fog::Parsers::Compute::AWS::Basic.new
          )
        end
      end

      class Mock
        def delete_vpn_connection_route(destination_cidr_block, vpn_connection_id)
          raise "Not yet implemented"
        end
      end
    end
  end
end
