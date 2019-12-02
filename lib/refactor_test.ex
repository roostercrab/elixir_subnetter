defmodule SubnetterRefactor do
  @moduledoc """
  Documentation for Subnetter.
  """
  def main(ip_address, subnet_mask) do
    break_up_dotted_decimal(ip_address, subnet_mask)
    |> convert_decimal_to_binary
    |> ensure_8_bit_length
    # |> measure_network_portion
    # |> calculate_subnet_range
    # |> convert_binary_to_dotted_decimal
  end

  def break_up_dotted_decimal(ip_address, subnet_mask) do
    ip_address_list = String.split(ip_address, ".")
    [ip_octet_1, ip_octet_2, ip_octet_3, ip_octet_4] = ip_address_list

    subnet_mask_list = String.split(subnet_mask, ".")
    [mask_octet_1, mask_octet_2, mask_octet_3, mask_octet_4] = subnet_mask_list

    ip_address_list ++ subnet_mask_list
  end

  def convert_decimal_to_binary(combined_list) do
    integer_list =
      for octet <- combined_list do
        String.to_integer(octet, 10)
      end

    bin_list =
      for octet <- integer_list do
        Integer.to_string(octet, 2)
      end
  end

  def ensure_8_bit_length(bin_list) do
    prepared_list =
      for octet <- bin_list do
        number_of_bits = String.length(octet)
        needed_zeroes = 8 - number_of_bits

        cond do
          needed_zeroes == 0 ->
            octet

          needed_zeroes >= 1 ->
            zeroes = List.duplicate("0", needed_zeroes)
            "#{zeroes ++ octet}"
        end
      end
  end
end
