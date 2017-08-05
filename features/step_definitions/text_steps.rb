# Iter 4-2
Given (/^the following texts exist:$/) do |texts_table|
  texts_table.hashes.each do |text|
    Text.create!(text)
  end
end