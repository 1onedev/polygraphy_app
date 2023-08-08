module Transactions
  class Create
    include Interactor

    delegate :params, to: :context # in
    delegate :transaction, :order, to: :context # out

    def call
      context.order = Order.find_by(uid: params['order_id'])
      context.transaction = Transaction.find_or_initialize_by(order_id: order.id, payment_id: params['payment_id'])
      transaction.amount = params['amount'] # Сумма
      transaction.status = params['status'] # Статус
      transaction.acq_id = params['acq_id'] # ID эквайера Number
      transaction.completion_date = params['completion_date'] # Дата списания средств
      transaction.create_date = params['create_date'] # Дата создания платежа
      transaction.err_code = params['err_code'] # Код ошибки
      transaction.err_code = params['err_description'] # Код ошибки
      transaction.liqpay_order_id = params['liqpay_order_id'] # Order_id платежа в системе LiqPay
      transaction.paytype = params['paytype'] # Способ оплаты.
      transaction.sender_card_bank = params['sender_card_bank'] # Банк отправителя
      transaction.sender_card_mask2 = params['sender_card_mask2'] # Карта отправителя
      transaction.sender_card_type = params['sender_card_type'] # Тип карты отправителя MC/Visa
      transaction.sender_first_name = params['sender_first_name'] # Имя отправителя
      transaction.sender_last_name = params['sender_last_name'] # Фамилия отправителя
      transaction.sender_phone = params['sender_phone'] # Телефон отправителя

      transaction.save!
    end  
  end
end    