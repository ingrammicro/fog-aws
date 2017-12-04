module Fog
  module Parsers
    module Compute
      module AWS
        class VpnConnectionParser < Fog::Parsers::Base
          def reset_vpn_connection
            @vpn_connection = { 'options' => {}, 'tagSet' => {}, 'routes' => {}, 'vgwTelemetry' => [] }
            @in_tag_set     = false
            @in_options = false
            @in_routes = false
            @in_vgw_telemetry = false
          end

          def reset
            reset_vpn_connection
          end

          def start_element(name, attrs = [])
            super
            case name
            when 'tagSet'
              @in_tag_set = true
              @tag        = {}
            when 'options'
              @in_options = true
            when 'routes'
              @in_routes = true
              @route     = {}
            when 'vgwTelemetry'
              @in_vgw_telemetry = true
              @vgw_telemetry    = {}
            end
          end

          def end_element(name)
            if @in_tag_set
              case name
              when 'item'
                @vpn_connection['tagSet'][@tag['key']] = @tag['value']
                @tag = {}
              when 'key', 'value'
                @tag[name] = value
              when 'tagSet'
                @in_tag_set = false
              end
            elsif @in_options
              case name
              when 'staticRoutesOnly'
                @vpn_connection['options'][name] = value == 'true'
              when 'options'
                @in_options = false
              end
            elsif @in_routes
              case name
              when 'item'
                cidr = @route.delete('destinationCidrBlock')
                @vpn_connection['routes'][cidr] = @route
                @route = {}
              when 'destinationCidrBlock', 'source', 'state'
                @route[name] = value
              when 'routes'
                @in_routes = false
              end
            elsif @in_vgw_telemetry
              case name
              when 'item'
                @vpn_connection['vgwTelemetry'] << @vgw_telemetry
                @vgw_telemetry = {}
              when 'lastStatusChange', 'outsideIpAddress', 'status', 'statusMessage'
                @vgw_telemetry[name] = value
              when 'acceptedRouteCount'
                @vgw_telemetry[name] = value.to_i
              when 'routes'
                @in_vgw_telemetry = false
              end
            else
              case name
              when 'category', 'customerGatewayConfiguration', 'customerGatewayId', 'state', 'type', 'vpnConnectionId', 'vpnGatewayId'
                @vpn_connection[name] = value
              else
                super
              end
            end
          end
        end
      end
    end
  end
end
