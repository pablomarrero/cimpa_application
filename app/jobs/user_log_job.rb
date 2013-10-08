class UserLogJob
  include SuckerPunch::Job

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      User.all.each { |user| Rails.logger.info "Usuario #{user.email} -> Last login #{user.last_sign_in_at}" }
    end
  end
end
