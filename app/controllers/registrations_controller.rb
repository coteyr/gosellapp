# @Author: Robert D. Cotey II <coteyr@coteyr.net>
# @Date:   2017-01-01 11:25:51
# @Last Modified by:   Robert D. Cotey II <coteyr@coteyr.net>
# @Last Modified time: 2017-01-01 11:27:30

class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation, :permission_level)
  end

  def account_update_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
