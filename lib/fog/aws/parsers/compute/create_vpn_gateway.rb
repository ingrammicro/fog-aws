module Fog
  module Parsers
    module AWS
      module Compute
        require 'fog/aws/parsers/compute/vpn_gateway_parser'

        class CreateVpnGateway < VpnGatewayParser
          def reset
            super
            @response = { 'vpnGateway' => {} }
          end

          def end_element(name)
            case name
            when 'requestId'
              @response[name] = value
            when 'vpnGateway'
              @response['vpnGateway'] = @vpn_gateway
            else
              super
            end
          end
        end
      end
    end
  end
end
