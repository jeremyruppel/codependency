require 'rspec/approvals'

module Approvals

end

##
# Simple shared context for allowing fixture-based examples to be
# declared by using the example and example group names.
# See graph_spec.rb for examples.
shared_context 'fixtures', :fixtures => true do
  let( :dirname  ){ example.example_group.description }
  let( :basename ){ example.description }
  let( :file ){ File.join './spec/fixtures', dirname, basename }

  before { subject.path << './spec/fixtures' }
end
