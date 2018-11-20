module Fog
  module AWS
    class Compute
      class Real
        require 'fog/aws/parsers/compute/describe_customer_gateways'

        # Describe all or specified customer_gateways
        #
        # ==== Parameters
        # * filters<~Hash> - List of filters to limit results with
        #
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - Id of request
        # * 'customerGatewaySet'<~Array>:
        # *   'bgpAsn'<~Long> - Autonomous System Number (ASN) for the Amazon side of a BGP session.
        # *   'ipAddress'<~String> - Internet-routable IP address of the customer gateway's outside interface.
        # *   'state'<~String> - The state of the customer gateway
        # *   'tagSet'<~Array>: Tags assigned to the resource.
        # *     'key'<~String> - Tag's key
        # *     'value'<~String> - Tag's value
        # *   'type'<~String> - The type of customer connection the virtual private gateway supports.
        # *   'customerGatewayId'<~String> - The ID of the virtual private gateway
        #
        # {Amazon API Reference}[http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeCustomerGateways.html]
        def describe_customer_gateways(filters = {})
          unless filters.is_a?(Hash)
            Fog::Logger.warning("describe_customer_gateways with #{filters.class} param is deprecated, use customer_gateways('customer-gateway-id' => []) instead [light_black](#{caller.first})[/]")
            filters = {'customer-gateway-id' => [*filters]}
          end
          params = Fog::AWS.indexed_filters(filters)
          request({
            'Action' => 'DescribeCustomerGateways',
            :idempotent => true,
            :parser => Fog::Parsers::AWS::Compute::DescribeCustomerGateways.new
          }.merge!(params))
        end
      end

      class Mock
        def describe_customer_gateways(filters = {})
          raise "Not yet implemented!"
        end
      end
    end
  end
end
