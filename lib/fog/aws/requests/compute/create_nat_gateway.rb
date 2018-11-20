module Fog
  module AWS
    class Compute
      class Real
        require 'fog/aws/parsers/compute/create_nat_gateway'

        # Creates an NatGateway
        #
        # ==== Parameters
        # * subnetId<~String> - The ID of the subnet to associate with the network interface
        # * allocationId<~String> - The allocation ID of an Elastic IP address to associate with the NAT gateway.
        #
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - Id of request
        # * 'natGateway'<~Array>:
        # *   'subnetId'<~String> - Id of subnet
        # *   'natGatewayAddressSet' <~Array>:
        # *     'item'
        # *       'allocationId'<~String> - Id of allocation
        # *   'createTime'<~Timestamp> - Creation time
        # *   'vpcId'<~String> - Id of vpc
        # *   'natGatewayId'<~String> - The ID of the NAT gateway
        # *   'state'<~String> - The state of the NAT gateway
        #
        # {Amazon API Reference}[http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateNatGateway.html]
        def create_nat_gateway(subnetId, allocationId)
          request({
            'Action'        => 'CreateNatGateway',
            'SubnetId'      => subnetId,
            'AllocationId'  => allocationId,
            :parser         => Fog::Parsers::AWS::Compute::CreateNatGateway.new
          })
        end
      end

      class Mock
        def create_nat_gateway(subnetId, allocationId)
          response = Excon::Response.new
          if subnetId
            subnet = self.data[:subnets].find{ |s| s['subnetId'] == subnetId }
            if subnet.nil?
              raise Fog::AWS::Compute::Error.new("Unknown subnet '#{subnetId}' specified")
            else
              allocation = self.data[:address].find{ |s| s['allocationId'] == allocationId }
              if allocation.nil?
                raise Fog::AWS::Compute::Error.new("Unknown allocation '#{allocationId}' specified")
              else
                id = Fog::AWS::Mock.nat_gateway_id
                addresses = {}
                addresses['natGatewayAddressSet'] << {
                  'allocationId' => allocationId,
                }
  
                data = {
                  'subnetId'              => subnetId,
                  'natGatewayAddressSet'  => addresses,
                  'createTime'            => Fog::Time.now,
                  'vpcId'                 => 'mock-vpc-id',
                  'natGatewayId'          => id,
                  'state'                 => 'available'
                }
                self.data[:nat_gateways][id] = data
                response.body = {
                  'requestId'        => Fog::AWS::Mock.request_id,
                  'natGateway' => data
                }
                response
              end              
            end
          else
            response.status = 400
            response.body = {
              'Code'    => 'InvalidParameterValue',
              'Message' => "Invalid value '' for subnetId"
            }
          end
        end
      end
    end
  end
end
