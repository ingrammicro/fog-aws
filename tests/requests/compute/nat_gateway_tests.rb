Shindo.tests('Fog::Compute[:aws] | nat_gateway requests', ['aws']) do
    
      @nat_gateways_format = {
        'natGatewaySet' => [{
          'subnetId'                => String,
          'natGatewayAddressSet'    => Hash,
          'createTime'              => Time,
          'vpcId'                   => String,
          'natGatewayId'            => String,
          'state'                   => String,
          'tagSet'                  => Fog::Nullable::Hash,
        }],
        'requestId' => String
      }
    
      tests('success') do
        Fog::AWS::Compute::Mock.reset if Fog.mocking?
        @vpc=Fog::Compute[:aws].vpcs.create('cidr_block' => '10.0.10.0/24')
        @vpc_id = @vpc.id
        @subnet=Fog::Compute[:aws].subnets.create('vpc_id' => @vpc_id, 'cidr_block' => '10.0.10.0/24')
        @subnet_id = @subnet.subnet_id
        @address=Fog::Compute[:aws].address.create('domain' => 'vpc')
        @allocation_id = @address.allocation_id 
        @ngw_id = nil
    
        tests('#create_nat_gateway').formats(@nat_gateways_format) do
          data = Fog::Compute[:aws].create_nat_gateway(@subnet_id, @allocation_id).body
          @ngw_id = data['natGatewaySet'].first['natGatewayId']
          data
        end
    
        tests('#describe_nat_gateways').formats(@nat_gateways_format) do
          Fog::Compute[:aws].describe_nat_gateways.body
        end
    
        tests('#describe_nat_gateways with tags').formats(@nat_gateways_format) do
          Fog::Compute[:aws].create_tags @ngw_id, {"environment" => "production"}
          Fog::Compute[:aws].describe_nat_gateways.body
        end
    
        tests("#delete_nat_gateway('#{@ngw_id}')").formats(AWS::Compute::Formats::BASIC) do
          Fog::Compute[:aws].delete_nat_gateway(@ngw_id).body
        end
        @subnet.destroy
        @vpc.destroy
      end
    end
    