module Fog
  module AWS
    class ELBV2
      class Real
        require 'fog/aws/parsers/elbv2/basic'
        # Removes the specified tags from the specified resource.
        # http://docs.aws.amazon.com/ElasticLoadBalancing/latest/APIReference/API_RemoveTags.html
        #
        # ==== Parameters
        # * resource_id <~String> - The Amazon Resource Name (ARN) of the resource.
        # * keys <~Array> The tag keys for the tags to remove. Array of strings.
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'ResponseMetadata'<~Hash>:
        #       * 'RequestId'<~String> - Id of request
        def delete_tags(resources, tags)
          params = {}
          tags.keys.each_with_index do |key, index|
            index += 1 # should start at 1 instead of 0
            params.merge!("TagKeys.member.#{index}" => key)
          end

          request({
            'Action'=> 'RemoveTags',
            'ResourceArns.member.1' => resources.first,
            :parser             => Fog::Parsers::AWS::ELBV2::Basic.new
          }.merge!(params))
        end
      end

      class Mock

        def delete_tags(resource_id, keys)
          load_balancer = self.data[:load_balancers][resource_id]
          raise Fog::AWS::ELB::NotFound unless load_balancer

          keys.each {|key| self.data[:tags][resource_id].delete key}

          response = Excon::Response.new
          response.status = 200
          response.body = {
            "ResponseMetadata" => { "RequestId"=> Fog::AWS::Mock.request_id }
          }
          response
        end

      end
    end
  end
end
