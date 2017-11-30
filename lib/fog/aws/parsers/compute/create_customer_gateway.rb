module Fog
  module Parsers
    module Compute
      module AWS
        require 'fog/aws/parsers/compute/customer_gateway_parser'

        class CreateCustomerGateway < CustomerGatewayParser
          def reset
            super
            @response = { 'customerGateway' => {} }
          end

          def end_element(name)
            case name
            when 'requestId'
              @response[name] = value
            when 'customerGateway'
              @response['customerGateway'] = @customer_gateway
            else
              super
            end
          end
        end
      end
    end
  end
end
