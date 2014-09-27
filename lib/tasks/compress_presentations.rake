namespace :rename_regions do
  desc "Reconfigure table 'presentations' to be compressed"
  task default: :environment do
#    ALTER TABLE presentations
#      ENGINE=InnoDB
#      ROW_FORMAT=COMPRESSED 
#      KEY_BLOCK_SIZE=8;
  end
end
