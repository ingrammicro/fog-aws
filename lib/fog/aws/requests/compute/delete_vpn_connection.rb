module Fog
  module AWS
    class Compute
      class Real
        require 'fog/aws/parsers/compute/basic'
        # Deletes a VPN connection.
        #
        # ==== Parameters
        # * vpn_connection_id<~String> - The ID of the VPN connection you want to delete.
        #
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - Id of request
        # * 'return'<~Boolean> - Returns true if the request succeeds.
        #
        # {Amazon API Reference}[http://docs.amazonwebservices.com/AWSEC2/2012-03-01/APIReference/ApiReference-query-DeleteVpnConnection.html]
        def delete_vpn_connection(vpn_connection_id)
          request(
            'Action'       => 'DeleteVpnConnection',
            'VpnConnectionId' => vpn_connection_id,
            :parser => Fog::Parsers::AWS::Compute::Basic.new
          )
        end
      end

      class Mock
        def delete_vpn_connection(vpn_connection_id)
          raise "Not yet implemented"
        end
      end
    end
  end
end
