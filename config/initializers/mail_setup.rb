ActionMailer::Base.delivery_method = :sendmail

ActionMailer::Base.sendmail_settings = {
:location       => '/usr/sbin/sendmail',
:arguments      => '-i -t'
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"