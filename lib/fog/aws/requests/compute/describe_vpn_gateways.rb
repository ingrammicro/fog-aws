module Fog
  module Compute
    class AWS
      class Real
        require 'fog/aws/parsers/compute/describe_vpn_gateways'

        # Describe all or specified vpn_gateways
        #
        # ==== Parameters
        # * filters<~Hash> - List of filters to limit results with
        #
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - Id of request
        # * 'vpnGatewaySet'<~Array>:
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
        # {Amazon API Reference}[http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVpnGateways.html]
        def describe_vpn_gateways(filters = {})
          unless filters.is_a?(Hash)
            Fog::Logger.warning("describe_vpn_gateways with #{filters.class} param is deprecated, use vpn_gateways('vpn-gateway-id' => []) instead [light_black](#{caller.first})[/]")
            filters = {'vpn-gateway-id' => [*filters]}
          end
          params = Fog::AWS.indexed_filters(filters)
          request({
            'Action' => 'DescribeVpnGateways',
            :idempotent => true,
            :parser => Fog::Parsers::Compute::AWS::DescribeVpnGateways.new
          }.merge!(params))
        end
      end

      class Mock
        def describe_vpn_gateways(filters = {})
          raise "Not yet implemented!"
        end
      end
    end
  end
end
