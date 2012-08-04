require 'persistable'

class Foodtruck
  include Persistable
  
  field :name, type: String
  field :screen_name, type: String

  has_one :twitter_user
  #delegate :screen_name, to: :twitter_user
end
