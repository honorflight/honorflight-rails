FactoryGirl.define do
  factory :smtp_setting do
    smtp_server "MyString"
port 1
authentication "MyString"
username "MyString"
password "MyString"
enable_start_tls_auto false
open_ssl_verify_mode "MyString"
from_name "MyString"
default_url_options "MyString"
  end

end
