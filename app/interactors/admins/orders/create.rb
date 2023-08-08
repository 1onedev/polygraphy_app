module Admins
  module Orders
    class Create
      include Interactor
      delegate :params, to: :context # in
      delegate :order,  to: :context # out

      def call
        ActiveRecord::Base.transaction do
          context.order = Order.new(params)
          order.save!
          order.reload
          order.update!(
            number: order.id + 1000,
            uid: Base64.urlsafe_encode64([order.id, order.created_at.to_i].join)
          )
        end  
      rescue StandardError => e
        context.fail! error: e 
      end
    end
  end
end