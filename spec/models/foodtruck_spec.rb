require 'spec_helper'

describe Foodtruck do
  it { should be_a_kind_of Persistable }

  it { should have_field :name }
  it { should have_field :screen_name }
end
