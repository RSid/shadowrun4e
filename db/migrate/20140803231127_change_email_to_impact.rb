class ChangeEmailToImpact < ActiveRecord::Migration
  def change
    rename_column :armors, :email, :impact
  end
end
