defmodule SubnetterRefactor do
  @moduledoc """
  Documentation for Subnetter.
  """
  def main(ip_address, subnet_mask, %IPStruct{}) do
    break_up_dotted_decimal(ip_address, subnet_mask, %IPStruct{})
    |> convert_decimal_to_binary
    |> measure_network_range
  end

  def break_up_dotted_decimal(original_ip_address, original_subnet_mask, ip_struct = %IPStruct{}) do
    original_ip_address_list = String.split(original_ip_address, ".")

    [
      first_ip_octet_decimal,
      second_ip_octet_decimal,
      third_ip_octet_decimal,
      fourth_ip_octet_decimal
    ] = original_ip_address_list

    original_subnet_mask_list = String.split(original_subnet_mask, ".")
    [first_mask_octet_decimal, second_mask_octet_decimal, third_mask_octet_decimal, fourth_mask_octet_decimal] = original_subnet_mask_list

    ip_struct
    |> Map.put(
      first_ip_octet_decimal: first_ip_octet_decimal,
      second_ip_octet_decimal: second_ip_octet_decimal,
      third_ip_octet_decimal: third_ip_octet_decimal,
      fourth_ip_octet_decimal: fourth_ip_octet_decimal,
      first_mask_octet_decimal: first_mask_octet_decimal,
      second_mask_octet_decimal: second_mask_octet_decimal,
      third_mask_octet_decimal: third_mask_octet_decimal,
      fourth_mask_octet_decimal: fourth_mask_octet_decimal,
      original_ip_address_list: original_ip_address_list,
      original_subnet_mask_list: original_subnet_mask_list
    )
  end

  def convert_decimal_to_binary(ip_struct = %IPStruct{}) do
    ip_integer_list =
      for octet <- ip_struct.original_ip_address_list do
        String.to_integer(octet, 10)
      end

    ip_binary_list_maybe_not_32_bits =
      for octet <- ip_integer_list do
        Integer.to_string(octet, 2)
      end

    ip_binary_list_32_bits = 
      ensure_8_bit_length(ip_binary_list_maybe_not_32_bits)
  end

  defp ensure_8_bit_length(binary_list) do
    binary_prepared_list =
      for octet <- binary_list do
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

  def measure_network_range(binary_prepared_list) do
    [
      first_ip_octet_binary,
      second_ip_octet_binary,
      third_ip_octet_binary,
      fourth_ip_octet_binary,
      first_mask_octet_binary,
      second_mask_octet_binary,
      third_mask_octet_binary,
      fourth_mask_octet_binary
    ] = binary_prepared_list

    combined_bin_ip =
      "#{first_ip_octet_binary}#{second_ip_octet_binary}#{third_ip_octet_binary}#{
        fourth_ip_octet_binary
      }"

    combined_bin_mask =
      "#{first_mask_octet_binary}#{second_mask_octet_binary}#{third_mask_octet_binary}#{
        fourth_mask_octet_binary
      }"

    number_of_ones_in_mask =
      combined_bin_mask
      |> String.graphemes()
      |> Enum.count(&(&1 == "1"))

    network_portion_of_ip = String.slice(combined_bin_ip, 0..(number_of_ones_in_mask - 1))
    zeroes_for_subnet_address = List.duplicate("0", 32 - number_of_ones_in_mask)
    ones_for_broadcast_address = List.duplicate("1", 32 - number_of_ones_in_mask)

    binary_subnet_address = "#{network_portion_of_ip}#{zeroes_for_subnet_address}"
    binary_broadcast_address = "#{network_portion_of_ip}#{ones_for_broadcast_address}"

    dotted_decimal_subnet_address = binary_string_to_dotted_decimal(binary_subnet_address)
    dotted_decimal_broadcast_address = binary_string_to_dotted_decimal(binary_broadcast_address)

    [
      binary_subnet_address,
      dotted_decimal_subnet_address,
      binary_broadcast_address,
      dotted_decimal_broadcast_address,
      first_ip_octet_binary,
      second_ip_octet_binary,
      third_ip_octet_binary,
      fourth_ip_octet_binary,
      first_mask_octet_binary,
      second_mask_octet_binary,
      third_mask_octet_binary,
      fourth_mask_octet_binary,
      number_of_ones_in_mask,
      network_portion_of_ip,
      "#{zeroes_for_subnet_address}",
      "#{ones_for_broadcast_address}"
    ]
  end

  defp binary_string_to_dotted_decimal(binary_string) do
    for <<chunk::binary-size(8) <- binary_string>> do
      String.to_integer(chunk, 2)
    end
  end
end
