module Fog
  module Parsers
    module Compute
      module AWS
        class VpnGatewayParser < Fog::Parsers::Base
          def reset_vpn_gateway
            @vpn_gateway = { 'attachments' => {}, 'tagSet' => {} }
            @in_tag_set     = false
            @in_attachments = false
          end

          def reset
            reset_vpn_gateway
          end

          def start_element(name, attrs = [])
            super
            case name
            when 'tagSet'
              @in_tag_set = true
              @tag        = {}
            when 'attachments'
              @in_attachments = true
              @attachment     = {}
            end
          end

          def end_element(name)
            if @in_tag_set
              case name
              when 'item'
                @vpn_gateway['tagSet'][@tag['key']] = @tag['value']
                @tag = {}
              when 'key', 'value'
                @tag[name] = value
              when 'tagSet'
                @in_tag_set = false
              end
            elsif @in_attachments
              case name
              when 'item'
                @vpn_gateway['attachments'][@attachment['vpcId']] = @attachment['state']
                @attachment = {}
              when 'state', 'vpcId'
                @attachment[name] = value
              when 'attachments'
                @in_attachments = false
              end
            else
              case name
              when 'availabilityZone', 'state', 'type', 'vpnGatewayId'
                @vpn_gateway[name] = value
              when 'amazonSideAsn'
                @vpn_gateway[name] = value.to_i
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
