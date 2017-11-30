module Fog
  module Parsers
    module Compute
      module AWS
        require 'fog/aws/parsers/compute/vpn_gateway_parser'

        class DescribeVpnGateways < VpnGatewayParser
          def reset
            super
            @response = { 'vpnGatewaySet' => [] }
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
                @response['vpnGatewaySet'] << @vpn_gateway
                reset_vpn_gateway
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
