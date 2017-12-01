module Fog
  module Compute
    class AWS
      class VpnConnection < Fog::Model
        identity  :vpn_connection_id,               :aliases => 'vpnConnectionId'
        attribute :vpn_gateway_id,                  :aliases => 'vpnGatewayId'
        attribute :customer_gateway_id,             :aliases => 'customerGatewayId'
        attribute :category,                        :aliases => 'attachments'
        attribute :customer_gateway_configuration,  :aliases => 'customerGatewayConfiguration'
        attribute :options,                         :aliases => 'options'
        attribute :routes,                          :aliases => 'routes'
        attribute :state,                           :aliases => 'state'
        attribute :tag_set,                         :aliases => 'tagSet'
        attribute :type,                            :aliases => 'type'

        def tunnel_options=(tunnels)
          raise ArgumentError.new("tunnel_options must be an array") unless tunnels.is_a?(Array)
          tunnels.each do | tunnel |
            raise ArgumentError.new("tunnel options specification must be a hash") unless tunnel.is_a?(Hash)
            tunnel.keys.all? { |key| ['PreSharedKey', 'TunnelInsideCidr'].include?(key) } or
              raise ArgumentError.new("tunnel options specification entry must be PreSharedKey or TunnelInsideCidr")
          end
          @tunnel_options = tunnels
        end

        def tunnel_options
          @tunnel_options || []
        end

        def ready?
          state == 'available'
        end

        # Removes an existing VPN connection
        #
        # vpn_connection.destroy
        #
        # ==== Returns
        #
        # True or false depending on the result
        #
        def destroy
          requires :vpn_connection_id

          service.delete_vpn_connection(vpn_connection_id)
          true
        end

        # Create a VPN connection
        #
        #  >> g = AWS.vpn_connections.new(customer_gateway_id: "cgw-11223344", vpn_gateway_id: "vgw-11223344", type: "ipsec.1", options)
        #  >> g.save
        #
        # == Returns:
        #
        # requestId and a vpnConnection object
        #
        def save
          requires :customer_gateway_id, :vpn_gateway_id, :type
          opts = {
            'Options.StaticRoutesOnly' => options['staticRoutesOnly']
          }
          tunnel_options.each_with_index do |tunnel, idx|
            tunnel.each do |key, value|
              opts["Options.TunnelOptions.#{idx+1}.#{key}"] = tunnel[key]
            end
          end
          opts.delete_if {|key, value| value.nil?}
          data = service.create_vpn_connection(customer_gateway_id, vpn_gateway_id, type, opts).body['vpnConnection']
          new_attributes = data.reject {|key,value| key == 'requestId'}
          merge_attributes(new_attributes)
          true
        end

        def create_route(destination_cidr_block)
          requires :vpn_connection_id
          service.create_vpn_connection_route(destination_cidr_block, vpn_connection_id)
          reload
        end

        def delete_route(destination_cidr_block)
          requires :vpn_connection_id
          service.delete_vpn_connection_route(destination_cidr_block, vpn_connection_id)
          reload
        end
      end
    end
  end
end
