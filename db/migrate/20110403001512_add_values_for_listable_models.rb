class AddValuesForListableModels < ActiveRecord::Migration
  require File.expand_path('../../seeds/system_data', __FILE__)
  
  def self.up
    SystemData.new.load_data

  end

  def self.down
    SystemData.new.clear_models   
  end

end
