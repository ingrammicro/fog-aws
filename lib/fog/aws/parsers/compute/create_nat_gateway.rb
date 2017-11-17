module Fog
    module Parsers
      module Compute
        module AWS
          class CreateNatGateway < Fog::Parsers::Base
            def reset
              @nat_gateway = { 'natGatewayAddressSet' => {}, 'tagSet' => {} }
              @response = { 'natGatewaySet' => [] }
              @tag = {}
              @address = {}
            end
  
            def start_element(name, attrs = [])
              super
              case name
              when 'tagSet'
                @in_tag_set = true
              when 'natGatewayAddressSet'
                @in_address_set = true
              end
            end
  
            def end_element(name)
              if @in_tag_set
                case name
                  when 'item'
                    @nat_gateway['tagSet'][@tag['key']] = @tag['value']
                    @tag = {}
                  when 'key', 'value'
                    @tag[name] = value
                  when 'tagSet'
                    @in_tag_set = false
                end
              elsif @in_address_set
                case name
                  when 'item'
                    @nat_gateway['natGatewayAddressSet'] = @address
                    @address = {}
                  when 'allocationId'
                    @address[name] = value
                    @nat_gateway[name] = value
                  when 'natGatewayAddressSet'
                    @in_address_set = false
                end
              else                
                case name
                  when 'natGatewayId', 'state', 'subnetId', 'vpcId', 'failureMessage', 'failureCode', 'createTime', 'deleteTime'
                    @nat_gateway[name] = value
                  when 'createTime', 'deleteTime'
                    @nat_gateway[name] = Time.parse(value)
                  when 'natGateway'
                    @response['natGatewaySet'] << @nat_gateway
                    @nat_gateway = { 'natGatewayAddressSet' => {}, 'tagSet' => {} }
                  when 'requestId'
                    @response[name] = value
                end
              end
            end
          end
        end
      end
    end
  end
  