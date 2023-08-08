class ItemFilesController < BaseController
  def update
    identifier = SecureRandom.hex(10)
    ItemFile.create!(file: params[:file], identifier: identifier)

    render json: { identifier: identifier }
  end
end