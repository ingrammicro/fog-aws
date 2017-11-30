require 'fog/aws/models/compute/customer_gateway'

module Fog
  module Compute
    class AWS
      class CustomerGateways < Fog::Collection
        attribute :filters

        model Fog::Compute::AWS::CustomerGateway

        # Creates a new customer gateway
        #
        # AWS.customer_gateways.new
        #
        # ==== Returns
        #
        # Returns the details of the new customer gateway
        #
        #>> AWS.customer_gateways.new(type: "ipsec.1", ip_address: "11.22.33.44", options)
        #    <Fog::Compute::AWS::CustomerGateway
        #      customer_gateway_id="cgw-11223344",
        #      ip_address: "11.22.33.44"
        #      bgp_asn=65000,
        #      state="available"
        #      tag_set={},
        #      type="ipsec.1"
        #    >
        #

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        # Returns an array of all customer gateways that have been created
        #
        # AWS.customer_gateways.all
        #
        # ==== Returns
        #
        # Returns an array of all customer gateways
        #
        #>> AWS.network_interfaves.all
        #  <Fog::AWS::Compute::CustomerGateways
        #    filters={}
        #    [
        #      <Fog::Compute::AWS::CustomerGateway
        #        customer_gateway_id="cgw-11223344",
        #        ip_address: "11.22.33.44"
        #        bgp_asn=65000,
        #        state="available"
        #        tag_set={},
        #        type="ipsec.1"
        #      >
        #    ]
        #  >
        #

        def all(filters_arg = filters)
          filters = filters_arg
          data = service.describe_customer_gateways(filters).body
          load(data['customerGatewaySet'])
        end

        # Used to retrieve a customer gateway
        # customer gateway id is required to get any information
        #
        # You can run the following command to get the details:
        # AWS.customer_gateways.get("vgw-11223344")
        #
        # ==== Returns
        #
        #>> AWS.CustomerGateway.get("vgw-11223344")
        #  <Fog::AWS::Compute::CustomerGateway
        #    customer_gateway_id="cgw-11223344",
        #    ip_address: "11.22.33.44"
        #    bgp_asn=65000,
        #    state="available"
        #    tag_set={},
        #    type="ipsec.1"
        #  >
        #

        def get(customer_gateway_id)
          if customer_gateway_id
            self.class.new(:service => service).all('customer-gateway-id' => customer_gateway_id).first
          end
        end
      end
    end
  end
end
