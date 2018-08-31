module Fog
  module Compute
    class AWS
      class Real

        # Unassigns one or more secondary private IP addresses from the specified network interface.
        #
        # ==== Parameters
        # * NetworkInterfaceId<~String> - The ID of the network interface
        # * PrivateIpAddress<~Array> - One or more private IP addresses to be unassigned from secondary private IP addresses
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - The ID of the request.
        #     * 'return'<~Boolean> - success?
        #
        # {Amazon API Reference}[https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_UnassignPrivateIpAddresses.html]
        def unassign_private_ip_addresses(network_interface_id, private_ip_addresses)
          request({
            'Action'  => 'UnassignPrivateIpAddresses',
            'NetworkInterfaceId' => network_interface_id,
            :parser   => Fog::Parsers::Compute::AWS::Basic.new
          }.merge(Fog::AWS.indexed_param('PrivateIpAddress.%d', [*private_ip_addresses])))
        end
      end

      class Mock
        def unassign_private_ip_addresses(network_interface_id, options={})
          response = Excon::Response.new
          response.status = 200
          response.body = {
            'requestId' => Fog::AWS::Mock.request_id,
            'return' => true
          }
          response
        end
      end
    end
  end
end
