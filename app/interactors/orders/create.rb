module Orders
  class Create
    include Interactor
    delegate :order, :params, :password, to: :context # in
    delegate :user, to: :context # out

    before { normalize_params }

    def call
      ActiveRecord::Base.transaction do
        order.assign_attributes(params)
        order.pending!
        order.reload
        process_user if order.create_account?
      end
    rescue StandardError => e
      context.fail! error: e
    end

    private

    def process_user
      context.user = find_user
      return process_user_order unless user.new_record?
      
      user.email = prepare_email if user.email.blank?
      user.phone = order.phone if user.phone.blank?
      user.name = order.name if user.name.blank?
      user.password = prepare_password if user.encrypted_password.blank?
      user.save!
      process_user_order
    end

    def process_user_order
      order.update!(user: user)
    end

    def find_user
      User.find_by(email: order.email) || User.find_by(phone: order.phone) || User.new
    end

    def prepare_email
      return order.email if order.email.present?

      user.skip_confirmation!
      "change-#{SecureRandom.random_number(10000)}@me.com"
    end

    def prepare_password
      context.password.present? ? context.password : SecureRandom.urlsafe_base64(nil, false)
    end

    def normalize_params
      params[:email] = params[:email]&.strip
      params[:phone] = params[:phone]&.strip
      params[:name]  = params[:name]&.strip
    end
  end
end
