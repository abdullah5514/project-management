module RequestHelpers
  def json
    JSON.parse(response.body)
  end

  def valid_headers
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{user.generate_jwt}"
    }
  end
end
