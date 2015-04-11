module ActiveRecordEncryptionKey

  extend ActiveSupport::Concern

  def encryption_key
    self.class.encryption_key
  end

  module ClassMethods
    def encryption_key
      ENV["ENCRYPTION_KEY_#{model_name.to_s.upcase}"]
    end
  end
end

# include the extension 
ActiveRecord::Base.send(:include, ActiveRecordEncryptionKey)