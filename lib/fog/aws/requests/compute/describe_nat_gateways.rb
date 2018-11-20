module Fog
  module AWS
    class Compute
      class Real
        require 'fog/aws/parsers/compute/describe_nat_gateways'

        # Describe all or specified nat_gateways
        #
        # ==== Parameters
        # * filters<~Hash> - List of filters to limit results with
        #
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - Id of request
        # * 'natGateway'<~Array>:
        # *   'subnetId'<~String> - Id of subnet
        # *   'natGatewayAddressSet' <~Array>:
        # *     'item'
        # *       'allocationId'<~String> - Id of allocation
        # *   'createTime'<~String> - Creation time
        # *   'vpcId'<~String> - Id of vpc
        # *   'natGatewayId'<~String> - The ID of the NAT gateway
        # *   'state'<~String> - The state of the NAT gateway
        # *   'tagSet'<~Array>: Tags assigned to the resource.
        # *     'key'<~String> - Tag's key
        # *     'value'<~String> - Tag's value
        #
        # {Amazon API Reference}[http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeNatGateways.html]
        def describe_nat_gateways(filters = {})
          unless filters.is_a?(Hash)
            Fog::Logger.warning("describe_nat_gateways with #{filters.class} param is deprecated, use nat_gateways('nat-gateway-id' => []) instead [light_black](#{caller.first})[/]")
            filters = {'nat-gateway-id' => [*filters]}
          end
          params = Fog::AWS.indexed_filters(filters)
          request({
            'Action' => 'DescribeNatGateways',
            :idempotent => true,
            :parser => Fog::Parsers::AWS::Compute::DescribeNatGateways.new
          }.merge!(params))
        end
      end

      class Mock
        def describe_nat_gateways(filters = {})
          nat_gateways = self.data[:nat_gateways].values

          if filters['nat-gateway-id']
            nat_gateways = nat_gateways.reject {|nat_gateway| nat_gateway['natGatewayId'] != filters['nat-gateway-id']}
          end

          Excon::Response.new(
            :status => 200,
            :body   => {
              'requestId'      => Fog::AWS::Mock.request_id,
              'natGatewaySet'  => nat_gateways
            }
          )
        end
      end
    end
  end
end
