ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :user_name            => 'tagkast_admin@poggled.com',
    :password             => 'RnNpqdmT',
    :authentication       => 'plain',
    :enable_starttls_auto => true 
  } 
 
ActionMailer::Base.delivery_method = :smtp
