module AccountBlock
    class InvitedAccount < Account
      include Wisper::Publisher
      validates :email, presence: true
    end
  end
  