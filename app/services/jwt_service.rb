class JwtService
  def initialize(request)
    @request = request
  end

  def decode_token
    token = extract_token_from_header
    return nil if token.blank?

    JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!).first
  rescue JWT::DecodeError
    nil
  end

  private

  def extract_token_from_header
    header = @request.headers['Authorization']
    header&.split(' ')&.last
  end
end
