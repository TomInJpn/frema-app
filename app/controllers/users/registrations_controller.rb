class Users::RegistrationsController < Devise::RegistrationsController

  def new
    session["devise.regist_data"]=nil if session["devise.regist_data"]
    super
  end

  def create
    @user=User.new(sign_up_params)
    unless @user.valid?
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_address
    render :new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    resource.remember_me = true
    sign_in(:user, @user)
  end

  protected

  def address_params
    params.require(:address).permit(
      :family_name_kanji,
      :first_name_kanji,
      :family_name_kana,
      :first_name_kana,
      :post_number,
      :prefecture_id,
      :city,
      :block_number,
      :apartment_name,
      :phone_number
    )
  end

end
