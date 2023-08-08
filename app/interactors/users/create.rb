module Users
  class Create
    include Interactor
    delegate :email, :password, :phone, :name, to: :context # in
    delegate :user, to: :context # out

    def call
      context.user = User.new
      user.email = email&.strip&.downcase
      user.password = password
      user.phone = Phoner::Phone.parse(phone).to_s
      user.name = name&.strip&.downcase
      user.autocomplete_value = [user.name, user.phone].join(' ')
      user.save!
    end
  end
end
