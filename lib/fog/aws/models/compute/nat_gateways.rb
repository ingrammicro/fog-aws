require 'fog/aws/models/compute/nat_gateway'

module Fog
  module AWS
    class Compute
      class NatGateways < Fog::Collection
        attribute :filters

        model Fog::Compute::AWS::NatGateway

        # Creates a new nat gateway
        #
        # AWS.nat_gateways.new
        #
        # ==== Returns
        #
        # Returns the details of the new NatGateway
        #
        #>> AWS.nat_gateways.new
        #=>   <Fog::Compute::AWS::NatGateway
        #id=nil,
        #attachment_set=nil,
        #tag_set=nil
        #>
        #

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        # Returns an array of all NatGateways that have been created
        #
        # AWS.nat_gateways.all
        #
        # ==== Returns
        #
        # Returns an array of all NatGateways
        #
        #>> AWS.nat_gateways.all
        #<Fog::Compute::AWS::NatGateways
        #filters={}
        #[
        #<Fog::Compute::AWS::NatGateway
        #id="igw-some-id",
        #attachment_set={"vpcId"=>"vpc-some-id", "state"=>"available"},
        #tag_set={}
        #>
        #]
        #>
        #

        def all(filters_arg = filters)
          unless filters_arg.is_a?(Hash)
            Fog::Logger.warning("all with #{filters_arg.class} param is deprecated, use all('nat-gateway-id' => []) instead [light_black](#{caller.first})[/]")
            filters_arg = {'nat-gateway-id' => [*filters_arg]}
          end
          filters = filters_arg
          data = service.describe_nat_gateways(filters).body
          load(data['natGatewaySet'])
        end

        # Used to retrieve an NatGateway
        #
        # You can run the following command to get the details:
        # AWS.nat_gateways.get("igw-12345678")
        #
        # ==== Returns
        #
        #>> AWS.nat_gateways.get("igw-12345678")
        #=>   <Fog::Compute::AWS::NatGateway
        #id="igw-12345678",
        #attachment_set={"vpcId"=>"vpc-12345678", "state"=>"available"},
        #tag_set={}
        #>
        #

        def get(nat_gateway_id)
          if nat_gateway_id
            self.class.new(:service => service).all('nat-gateway-id' => nat_gateway_id).first
          end
        end
      end
    end
  end
end
