class NewsletterUser < ActiveRecord::Base
    attr_accessible :email

    #private
    def NewsletterUser.all_newsletter_users
      return NewsletterUser.select('email').map{ |e| e.email }.to_a
    end

    def NewsletterUser.is_valid_newsletter_user(user)
      NewsletterUser.all_newsletter_users.include? user
    end

    def NewsletterUser.find_by_email(email)
      result = NewsletterUser.where("email = ?", email).first
      if !result
        return nil
      end
      return result
    end
end
