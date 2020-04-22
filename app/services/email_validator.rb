class EmailValidator
  def self.call(email)
    return true if email =~ URI::MailTo::EMAIL_REGEXP
    return false
  end
end