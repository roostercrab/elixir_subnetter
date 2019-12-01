defmodule BinarySubnetter do
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
    first_octet_binary = << first_octet :: size(8) >>
    second_octet_binary = << second_octet :: size(8) >>
    third_octet_binary = << third_octet :: size(8) >>
    fourth_octet_binary = << fourth_octet :: size(8) >>

    IO.inspect(first_octet_binary)
    IO.inspect(second_octet_binary)
    IO.inspect(third_octet_binary)
    IO.inspect(fourth_octet_binary)

    
  end
end
