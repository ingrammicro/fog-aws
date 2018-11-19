module Fog
  module Parsers
    module AWS
      class Compute
        class CustomerGatewayParser < Fog::Parsers::Base
          def reset_customer_gateway
            @customer_gateway = { 'tagSet' => {} }
            @in_tag_set     = false
          end

          def reset
            reset_customer_gateway
          end

          def start_element(name, attrs = [])
            super
            case name
            when 'tagSet'
              @in_tag_set = true
              @tag        = {}
            end
          end

          def end_element(name)
            if @in_tag_set
              case name
              when 'item'
                @customer_gateway['tagSet'][@tag['key']] = @tag['value']
                @tag = {}
              when 'key', 'value'
                @tag[name] = value
              when 'tagSet'
                @in_tag_set = false
              end
            else
              case name
              when 'customerGatewayId', 'ipAddress', 'state', 'type'
                @customer_gateway[name] = value
              when 'bgpAsn'
                @customer_gateway[name] = value.to_i
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
