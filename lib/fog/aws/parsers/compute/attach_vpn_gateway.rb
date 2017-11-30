module Fog
  module Parsers
    module Compute
      module AWS
        class AttachVpnGateway < Fog::Parsers::Base

          def reset
            @response = { 'attachment' => {} }
            @in_attachment = false
          end

          def start_element(name, attrs = [])
            super
            case name
            when 'attachment'
              @in_attachment = true
              @attachment = {}
            end
          end

          def end_element(name)
            if @in_attachment
              case name
              when 'state', 'vpcId'
                @attachment[name] = value
              when 'attachment'
                @response[name] = @attachment
                @in_attachment = false
              end
            else
              case name
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
