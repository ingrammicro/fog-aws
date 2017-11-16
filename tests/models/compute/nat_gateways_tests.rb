Shindo.tests("Fog::Compute[:aws] | nat_gateways", ['aws']) do
    collection_tests(Fog::Compute[:aws].nat_gateways, {}, true)
end