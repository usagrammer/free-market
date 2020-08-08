class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  after_validation :display_validation_result

  private
  def display_validation_result
return false
    ## testのときはオフ
    # return false if Rails.env.test?

    puts "============【display_validation_result】============"
    puts "◆◆◆◆◆◆#{self.class.name}モデル◆◆◆◆◆◆"
    puts "+++++属性一覧++++++"
    self.attributes.each do |key, value|
      puts "#{key}: #{value}"
    end

    if self.class.name == "User"
      puts "password: #{self.password}"
    end

    puts "++++++++++++++++++++++++++++"
    puts "★★★★★★バリデーションエラー★★★★★★"
    if self.errors.messages.length == 0
      puts "発生しませんでした"
    else
      puts "バリデーションエラー発生"
      puts self.errors.messages
      # binding.pry
    end
    puts "★★★★★★★★★★★★★★★★★★★★★★★★★★★★★"
    puts "==========================="
  end

end
