module Fog
  module Compute
    class AWS
      class Real
        require 'fog/aws/parsers/compute/basic'
        # Deletes a customer gateway.
        #
        # ==== Parameters
        # * customer_gateway_id<~String> - The ID of the customer gateway you want to delete.
        #
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - Id of request
        # * 'return'<~Boolean> - Returns true if the request succeeds.
        #
        # {Amazon API Reference}[http://docs.amazonwebservices.com/AWSEC2/2012-03-01/APIReference/ApiReference-query-DeleteCustomerGateway.html]
        def delete_customer_gateway(customer_gateway_id)
          request(
            'Action'            => 'DeleteCustomerGateway',
            'CustomerGatewayId' => customer_gateway_id,
            :parser => Fog::Parsers::Compute::AWS::Basic.new
          )
        end
      end

      class Mock
        def delete_customer_gateway(customer_gateway_id)
          raise "Not yet implemented"
        end
      end
    end
  end
end
