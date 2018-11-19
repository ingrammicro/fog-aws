module Fog
  module Parsers
    module AWS
      class Compute
        require 'fog/aws/parsers/compute/customer_gateway_parser'

        class DescribeCustomerGateways < CustomerGatewayParser
          def reset
            super
            @response = { 'customerGatewaySet' => [] }
            @item_level = 0
          end

          def start_element(name, attrs = [])
            super
            case name
            when 'item'
              @item_level += 1
            end
          end

          def end_element(name)
            case name
            when 'requestId'
              @response[name] = value
            when 'item'
              @item_level -= 1
              if @item_level == 0
                @response['customerGatewaySet'] << @customer_gateway
                reset_customer_gateway
              else
                super
              end
            else
              super
            end
          end
        end
      end
    end
  end
end
