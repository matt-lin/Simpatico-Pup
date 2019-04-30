Given /the following feedback exist/ do |feedbacks_table|
    feedbacks_table.hashes.each do |f|
      Feedback.create!(f)
    end
  end
