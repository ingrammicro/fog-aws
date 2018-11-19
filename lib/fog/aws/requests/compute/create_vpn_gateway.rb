module Fog
  module AWS
    class Compute
      class Real
        require 'fog/aws/parsers/compute/create_vpn_gateway'

        # Creates an VpnGateway (= virtual private gateway)
        #
        # ==== Parameters
        # * type<~String> - The type of VPN connection the virtual private gateway supports (ipsec.1).
        # * options<~Hash>:
        #   * AmazonSideAsn<~Long> Autonomous System Number (ASN) for the Amazon side of a BGP session. Default: 64512
        #   * AvailabilityZone<~String> Availability Zone for the virtual private gateway.
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - Id of request
        # * 'vpnGateway'<~Hash>:
        # *   'amazonSideAsn'<~Long> - Autonomous System Number (ASN) for the Amazon side of a BGP session.
        # *   'attachments' <~Array>:
        # *     'vpcId'<~String> - The ID of the VPC the VPN gateway is attached to.
        # *     'state'<~String> - The current state of the attachment.
        # *   'availabilityZone'<~String> - Availability Zone where the virtual private gateway was created.
        # *   'state'<~String> - The state of the VPN gateway
        # *   'tagSet'<~Array>: Tags assigned to the resource.
        # *     'key'<~String> - Tag's key
        # *     'value'<~String> - Tag's value
        # *   'type'<~String> - The type of VPN connection the virtual private gateway supports.
        # *   'vpnGatewayId'<~String> - The ID of the virtual private gateway
        #
        # {Amazon API Reference}[http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVpnGateway.html]
        def create_vpn_gateway(type, options = {})
          request({
            'Action'        => 'CreateVpnGateway',
            'Type'          => type,
            :parser         => Fog::Parsers::Compute::AWS::CreateVpnGateway.new
          }.merge!(options))
        end
      end

      class Mock
        def create_vpn_gateway(type, options = {})
          raise "Not yet implemented!"
        end
      end
    end
  end
end
