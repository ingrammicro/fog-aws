module Fog
  module Parsers
    module Compute
      module AWS
        require 'fog/aws/parsers/compute/vpn_connection_parser'

        class CreateVpnConnection < VpnConnectionParser
          def reset
            super
            @response = { 'vpnConnection' => {} }
          end

          def end_element(name)
            case name
            when 'requestId'
              @response[name] = value
            when 'vpnConnection'
              @response['vpnConnection'] = @vpn_connection
            else
              super
            end
          end
        end
      end
    end
  end
end
