require 'twitter'

class TwitterConnect
  def self.user(user)
    Twitter.user(user)
  end

  def self.latest(user)
    self.user(user).status
  end
end
