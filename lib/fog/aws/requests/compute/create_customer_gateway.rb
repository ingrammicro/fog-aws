module Fog
  module Compute
    class AWS
      class Real
        require 'fog/aws/parsers/compute/create_customer_gateway'

        # Creates an CustomerGateway (= virtual private gateway)
        #
        # ==== Parameters
        # * type<~String> - The type of VPN connection this customer gateway supports (ipsec.1).
        # * ip_address<~String> - The Internet-routable IP address for the customer gateway's outside interface.
        # * options<~Hash>:
        #   * BgpAsn<~Long> Customer gateway's BGP ASN. Default: 65000
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - Id of request
        # * 'customerGateway'<~Hash>:
        # *   'bgpAsn'<~Long> - Customer gateway's BGP ASN.
        # *   'ipAddress'<~String> - Internet-routable IP address of the customer gateway's outside interface.
        # *   'state'<~String> - The state of the customer gateway
        # *   'tagSet'<~Array>: Tags assigned to the resource.
        # *     'key'<~String> - Tag's key
        # *     'value'<~String> - Tag's value
        # *   'type'<~String> - The type of customer connection the virtual private gateway supports.
        # *   'customerGatewayId'<~String> - The ID of the virtual private gateway
        #
        # {Amazon API Reference}[http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateCustomerGateway.html]
        def create_customer_gateway(type, ip_address, options = {})
          request({
            'Action'        => 'CreateCustomerGateway',
            'Type'          => type,
            'IpAddress'     => ip_address,
            :parser         => Fog::Parsers::Compute::AWS::CreateCustomerGateway.new
          }.merge!(options))
        end
      end

      class Mock
        def create_customer_gateway(type, options = {})
          raise "Not yet implemented!"
        end
      end
    end
  end
end
