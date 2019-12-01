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

    IO.puts(first_octet)
    IO.puts(second_octet)
    IO.puts(third_octet)
    IO.puts(fourth_octet)

    raw_first_octet_binary = Integer.to_string(first_octet, 2)
    IO.puts(raw_first_octet_binary)

    raw_second_octet_binary = Integer.to_string(second_octet, 2)
    IO.puts(raw_second_octet_binary)

    raw_third_octet_binary = Integer.to_string(third_octet, 2)
    IO.puts(raw_third_octet_binary)

    raw_fourth_octet_binary = Integer.to_string(fourth_octet, 2)
    IO.puts(raw_fourth_octet_binary)

    make_eight_bits_long(raw_first_octet_binary)
    make_eight_bits_long(raw_second_octet_binary)
    make_eight_bits_long(raw_third_octet_binary)
    make_eight_bits_long(raw_fourth_octet_binary)
  end

  def make_eight_bits_long(binary) do
    case String.length(binary) do
      8 ->
        IO.puts("good binary")
      _ ->
        number_of_bits = String.length(binary)
        IO.puts(number_of_bits)
    end
  end

  
end
