module Fog
  module AWS
    class Compute
      class Real
        require 'fog/aws/parsers/compute/basic'
        # Deletes a VPN gateway.
        #
        # ==== Parameters
        # * vpn_gateway_id<~String> - The ID of the VPN gateway you want to delete.
        #
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - Id of request
        # * 'return'<~Boolean> - Returns true if the request succeeds.
        #
        # {Amazon API Reference}[http://docs.amazonwebservices.com/AWSEC2/2012-03-01/APIReference/ApiReference-query-DeleteVpnGateway.html]
        def delete_vpn_gateway(vpn_gateway_id)
          request(
            'Action'       => 'DeleteVpnGateway',
            'VpnGatewayId' => vpn_gateway_id,
            :parser => Fog::Parsers::AWS::Compute::Basic.new
          )
        end
      end

      class Mock
        def delete_vpn_gateway(vpn_gateway_id)
          raise "Not yet implemented"
        end
      end
    end
  end
end
