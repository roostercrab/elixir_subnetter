defmodule Subnetter do
  @moduledoc """
  Documentation for Subnetter.
  """
  def calculate_subnet_range(ip_address, subnet_mask) do
    binary_ip = dotted_decimal_to_binary(ip_address)
    IO.puts(binary_ip)
    binary_mask = dotted_decimal_to_binary(subnet_mask)
    IO.puts(binary_mask)

    


  end

  def dotted_decimal_to_binary(dotted_decimal) do
    string_dotted_decimal_with_new_line = to_string(dotted_decimal)
    string_dotted_decimal = String.trim(string_dotted_decimal_with_new_line, "\n")
    parsed_address = InetCidr.parse_address!(string_dotted_decimal)
    {first_octet, second_octet, third_octet, fourth_octet} = parsed_address

    raw_first_octet_binary = Integer.to_string(first_octet, 2)
    raw_second_octet_binary = Integer.to_string(second_octet, 2)
    raw_third_octet_binary = Integer.to_string(third_octet, 2)
    raw_fourth_octet_binary = Integer.to_string(fourth_octet, 2)
    
    first_octet_binary = make_eight_bits_long(raw_first_octet_binary)
    second_octet_binary = make_eight_bits_long(raw_second_octet_binary)
    third_octet_binary = make_eight_bits_long(raw_third_octet_binary)
    fourth_octet_binary = make_eight_bits_long(raw_fourth_octet_binary)

    binary_return = "#{first_octet_binary}#{second_octet_binary}#{third_octet_binary}#{fourth_octet_binary}"
  end

  def make_eight_bits_long(binary) do
    number_of_bits = String.length(binary)
    needed_zeroes = 8 - number_of_bits
    zeroes = List.duplicate("0", needed_zeroes)
    eight_bits = zeroes ++ binary
    
  end
end
