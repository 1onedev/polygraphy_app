class AddVideosToSliders < ActiveRecord::Migration[5.2]
  def change
    add_attachment :sliders, :video 
  end
end
