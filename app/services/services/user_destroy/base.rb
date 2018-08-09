module Services
module UserDestroy

class Base < BaseService

  def run
    destroy
  end

  def input_params
    [:user]
  end

  private

  def destroy
    raise 'Not Implemented'
  end

end

end
end
