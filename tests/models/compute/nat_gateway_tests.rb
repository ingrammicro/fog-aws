Shindo.tests("Fog::Compute[:aws] | nat_gateway", ['aws']) do
    model_tests(Fog::Compute[:aws].nat_gateways , {}, true)
  end