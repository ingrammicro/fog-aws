module Fog
  module Compute
    class AWS
      class Real
        require 'fog/aws/parsers/compute/basic'
        #Deletes an Nat gateway from your AWS account. The gateway must not be attached to a VPC
        #
        # ==== Parameters
        # * nat_gateway_id<~String> - The ID of the NatGateway you want to delete.
        #
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - The ID of the request
        # * 'natGatewayId'<~String> - The ID of the NAT gateway
        #
        # {Amazon API Reference}[http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteNatGateway.html]
        def delete_nat_gateway(nat_gateway_id)
          request(
            'Action' => 'DeleteNatGateway',
            'NatGatewayId' => nat_gateway_id,
            :parser => Fog::Parsers::Compute::AWS::Basic.new
          )
        end
      end

      class Mock
        def delete_nat_gateway(nat_gateway_id)
          Excon::Response.new.tap do |response|
            if nat_gateway_id
              response.status = 200
              self.data[:nat_gateways].delete(nat_gateway_id)

              response.body = {
                'requestId' => Fog::AWS::Mock.request_id,
                'natGatewayId' => nat_gateway_id.to_s
              }
            else
              message = 'MissingParameter => '
              message << 'The request must contain the parameter nat_gateway_id'
              raise Fog::Compute::AWS::Error.new(message)
            end
          end
        end
      end
    end
  end
end
