module Fog
  module AWS
    class Compute
      class Real
        require 'fog/aws/parsers/compute/attach_vpn_gateway'

        # Attach a VPN gateway
        #
        # ==== Parameters
        # * VpcId<~String> - ID of the VPC
        # * VpnGatewayId<~String> - ID of the virtual private gateway
        #
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String>   - Id of request
        # * 'return'<~Boolean>     - Is true if request succeeds
        #
        # {Amazon API Reference}[http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_AttachVpnGateway.html]
        def attach_vpn_gateway(vpc_id, vpn_gateway_id)
          request(
            'Action'        => 'AttachVpnGateway',
            'VpcId'         => vpc_id,
            'VpnGatewayId'  => vpn_gateway_id,
            :idempotent   => true,
            :parser => Fog::Parsers::Compute::AWS::AttachVpnGateway.new # AttachVpnGateway.new
          )
        end
      end

      class Mock
        def attach_vpn_gateway(vpc_id, vpn_gateway_id)
          raise ("Not yet implemented")
        end
      end
    end
  end
end
