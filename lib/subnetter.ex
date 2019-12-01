defmodule Subnetter do
  @moduledoc """
  Documentation for Subnetter.
  """
  def get_address_and_mask do
    ip_address = IO.gets("What is the IP address? ")
    # subnet_mask = IO.gets("What is the subnet mask? ")
    string_ip_address_with_new_line = to_string(ip_address)
    string_ip_address = String.trim(string_ip_address_with_new_line, "\n")
    parsed_address = InetCidr.parse_address!(string_ip_address)

    {first, second, third, fourth} = parsed_address
  end
end
