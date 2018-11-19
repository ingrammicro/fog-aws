module Fog
  module AWS
    class Compute
        class VpnGateway < Fog::Model
          identity  :vpn_gateway_id,                :aliases => 'vpnGatewayId'
          attribute :amazon_side_asn,               :aliases => 'amazonSideAsn'
          attribute :attachments,                   :aliases => 'attachments'
          attribute :availability_zone,             :aliases => 'availabilityZone'
          attribute :state,                         :aliases => 'state'
          attribute :tag_set,                       :aliases => 'tagSet'
          attribute :type,                          :aliases => 'type'

          def ready?
            state == 'available'
          end
  
          # Removes an existing VPN gateway
          #
          # vpn_gateway.destroy
          #
          # ==== Returns
          #
          # True or false depending on the result
          #
          def destroy
            requires :vpn_gateway_id
  
            service.delete_vpn_gateway(vpn_gateway_id)
            true
          end
  
          # Create a VPN gateway
          #
          #  >> g = AWS.vpn_gateways.new(type: "ipsec.1", options)
          #  >> g.save
          #
          # == Returns:
          #
          # requestId and a vpnGateway object
          #
          def save
            requires :type
            options = {
              'AmazonSideAsn'     => amazon_side_asn,
              'AvailabilityZone'  => availability_zone
            }
            options.delete_if {|key, value| value.nil?}
            data = service.create_vpn_gateway(type, options).body['vpnGateway']
            new_attributes = data.reject {|key,value| key == 'requestId'}
            merge_attributes(new_attributes)
            true
          end

          def attach(vpc_id)
            requires :vpn_gateway_id
            service.attach_vpn_gateway(vpc_id, vpn_gateway_id)
            reload
          end

          def attached?(vpc_id)
            attachments[vpc_id] == 'attached'
          end

          def detach(vpc_id)
            requires :vpn_gateway_id
            service.detach_vpn_gateway(vpc_id, vpn_gateway_id)
            reload
          end

          def detached?(vpc_id)
            attachments[vpc_id] == (nil || 'detached')
          end
        end
      end
    end
  end
  