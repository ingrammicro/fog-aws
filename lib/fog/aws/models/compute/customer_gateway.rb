module Fog
    module AWS
      class Compute
        class CustomerGateway < Fog::Model
          identity  :customer_gateway_id,           :aliases => 'customerGatewayId'
          attribute :bgp_asn,                       :aliases => 'bgpAsn'
          attribute :ip_address,                    :aliases => 'ipAddress'
          attribute :state,                         :aliases => 'state'
          attribute :tag_set,                       :aliases => 'tagSet'
          attribute :type,                          :aliases => 'type'

          def ready?
            state == 'available'
          end
  
          # Removes an existing customer gateway
          #
          # customer_gateway.destroy
          #
          # ==== Returns
          #
          # True or false depending on the result
          #
          def destroy
            requires :customer_gateway_id
  
            service.delete_customer_gateway(customer_gateway_id)
            true
          end
  
          # Create a customer gateway
          #
          #  >> g = AWS.customer_gateways.new(type: "ipsec.1", ip_address: "11.22.33.44", options)
          #  >> g.save
          #
          # == Returns:
          #
          # requestId and a customerGateway object
          #
          def save
            requires :type, :ip_address
            options = {
              'BgpAsn'     => bgp_asn
            }
            options.delete_if {|key, value| value.nil?}
            data = service.create_customer_gateway(type, ip_address, options).body['customerGateway']
            new_attributes = data.reject {|key,value| key == 'requestId'}
            merge_attributes(new_attributes)
            true
          end
        end
      end
    end
  end
  