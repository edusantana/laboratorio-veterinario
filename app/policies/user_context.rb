# As permissões variam se forem dentro a intranet ou fora.
class UserContext
  attr_reader :user, :intranet

  def initialize(user, intranet)
    @user = user
    @intranet   = intranet
  end

end