class Admin::DocumentsController < Admin::BaseController
  def edit
  end

  def update
    if documents.update!(documents_params)
      redirect_to edit_admin_documents_path, notice: "#{t :date_save}"
    else
      redirect_to :back, flash: { error: "#{t :date_error}" }
    end
  end

  private

  def documents_params
    params.require(:document).permit(
      :privacy_policy,
      :terms_of_use,
      :delivery,
      :payments,
      :protect_your_data,
      :return,
      :privacy_policy_ru,
      :terms_of_use_ru,
      :delivery_ru,
      :payments_ru,
      :protect_your_data_ru,
      :return_ru,
      :privacy_policy_en,
      :terms_of_use_en,
      :delivery_en,
      :payments_en,
      :protect_your_data_en,
      :return_en,
      :privacy_policy_he,
      :terms_of_use_he,
      :delivery_he,
      :payments_he,
      :protect_your_data_he,
      :return_he
    )
  end
end