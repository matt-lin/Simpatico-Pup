Given /the following customizes exist/ do |customizes_table|
    customizes_table.hashes.each do |c|
      Customize.create!(c)
    end
  end