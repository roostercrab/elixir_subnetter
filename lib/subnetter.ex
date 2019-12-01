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
    {first_octet, second_octet, third_octet, fourth_octet} = parsed_address

    raw_first_octet_binary = Integer.to_string(first_octet, 2)
    raw_second_octet_binary = Integer.to_string(second_octet, 2)
    raw_third_octet_binary = Integer.to_string(third_octet, 2)
    raw_fourth_octet_binary = Integer.to_string(fourth_octet, 2)
    
    first_octet_binary = make_eight_bits_long(raw_first_octet_binary)
    second_octet_binary = make_eight_bits_long(raw_second_octet_binary)
    third_octet_binary = make_eight_bits_long(raw_third_octet_binary)
    fourth_octet_binary = make_eight_bits_long(raw_fourth_octet_binary)
  end

  def make_eight_bits_long(binary) do
    number_of_bits = String.length(binary)
    needed_zeroes = 8 - number_of_bits
    zeroes = List.duplicate("0", needed_zeroes)
    eight_bits = zeroes ++ binary
    IO.puts(eight_bits)
  end
end
