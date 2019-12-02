defmodule Subnetter do
  @moduledoc """
  Documentation for Subnetter.
  """
  def main do
    
  end
  
  def calculate_subnet_range(ip_address, subnet_mask) do
    binary_ip = dotted_decimal_to_binary(ip_address)
    binary_mask = dotted_decimal_to_binary(subnet_mask)

    number_of_ones_in_mask =
      binary_mask
      |> String.graphemes()
      |> Enum.count(&(&1 == "1"))

    network_portion_of_ip = String.slice(binary_ip, 0..(number_of_ones_in_mask - 1))
    zeroes_for_subnet_address = List.duplicate("0", 32 - number_of_ones_in_mask)
    ones_for_broadcast_address = List.duplicate("1", 32 - number_of_ones_in_mask)

    binary_subnet_address = "#{network_portion_of_ip}#{zeroes_for_subnet_address}"
    binary_broadcast_address = "#{network_portion_of_ip}#{ones_for_broadcast_address}"

    dotted_decimal_subnet_address = binary_string_to_dotted_decimal(binary_subnet_address)

    dotted_decimal_broadcast_address =
      binary_string_to_dotted_decimal(binary_broadcast_address)

    {ip_address, subnet_mask, binary_subnet_address, binary_broadcast_address, dotted_decimal_subnet_address, dotted_decimal_broadcast_address}
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

    "#{first_octet_binary}#{second_octet_binary}#{third_octet_binary}#{fourth_octet_binary}"
  end

  def make_eight_bits_long(binary) do
    number_of_bits = String.length(binary)
    needed_zeroes = 8 - number_of_bits
    zeroes = List.duplicate("0", needed_zeroes)
    zeroes ++ binary
  end

  def binary_string_to_dotted_decimal(binary_string) do
    for <<chunk::binary-size(8) <- binary_string>> do
      String.to_integer(chunk, 2)
    end
  end
end
