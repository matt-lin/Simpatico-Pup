class Text < ActiveRecord::Base
  attr_accessible :title, :body

  # def Text.mission_statement_sections
  #   #get distinct mission statement sections
  #   statements = Text.where(:section_title => "Mission Statement").order(:section_order)
  #   statement_ids = Hash[statements.map{|statement| [statement.section_order, statement]}]
  #   statement_ids.values
  # end
  
end
