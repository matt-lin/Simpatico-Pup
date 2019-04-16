namespace :scheduler do
  desc "Drops old impressions records (8 days)"
  task clean_impressions: :environment do
    Impressions.where("updated_at < ?", Time.now - 8*24*60*60).destroy_all
  end

end
