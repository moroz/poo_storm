defmodule PooStorm.ValidationHelpers do
  def is_valid_website?(url) when is_binary(url) do
    uri = URI.parse(url)
    uri.scheme in ["http", "https"] and EmailTldValidator.tld_validate(uri.host)
  end
end
