class ChangeCommonNameToFingerprint < ActiveRecord::Migration
  def up
    rename_column :vens, :common_name, :fingerprint
  end

  def down
    rename_column :vens, :fingerprint, :common_name
  end
end
