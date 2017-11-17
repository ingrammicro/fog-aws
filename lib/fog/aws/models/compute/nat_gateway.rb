module Fog
    module Compute
      class AWS
        class NatGateway < Fog::Model
          identity  :id,                            :aliases => 'natGatewayId'
          attribute :create_time,                   :aliases => 'createTime'
          attribute :delete_time,                   :aliases => 'deleteTime'
          attribute :failure_code,                  :aliases => 'failureCode'
          attribute :failure_message,               :aliases => 'failureMessage'
          attribute :nat_gateway_address_set,       :aliases => 'natGatewayAddressSet'
          attribute :state,                         :aliases => 'state'
          attribute :subnet_id,                     :aliases => 'subnetId'
          attribute :tag_set,                       :aliases => 'tagSet'
          attribute :vpc_id,                        :aliases => 'vpcId'
          attribute :allocation_id,                 :aliases => 'allocationId'

          def ready?
            requires :state
            state == 'available'
          end
  
          def initialize(attributes={})
            super
          end
          
          # Removes an existing nat gateway
          #
          # nat_gateway.destroy
          #
          # ==== Returns
          #
          # True or false depending on the result
          #
          def destroy
            requires :id
  
            service.delete_nat_gateway(id)
            true
          end
  
          # Create an nat gateway
          #
          #  >> g = AWS.nat_gateways.new()
          #  >> g.save
          #
          # == Returns:
          #
          # requestId and a natGateway object
          #
          def save
            requires :subnet_id, :allocation_id
            data = service.create_nat_gateway(subnet_id, allocation_id).body['natGatewaySet'].first
            new_attributes = data.reject {|key,value| key == 'requestId'}
            merge_attributes(new_attributes)
            true
          end

          private

          def natGatewayAddressSet=(new_nat_gateway_address_set)
            merge_attributes(new_nat_gateway_address_set.first || {})
          end
  
          def tagSet=(new_tag_set)
            merge_attributes(new_tag_set || {})
          end
        end
      end
    end
  end
  