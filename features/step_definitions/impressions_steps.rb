Given /the following impressions exist/ do |impressions_table|
    impressions_table.hashes.each do |i|
      Impression.create!(i)
    end
  end