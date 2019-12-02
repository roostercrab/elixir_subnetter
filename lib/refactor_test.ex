defmodule SubnetterRefactor do
  @moduledoc """
  Documentation for Subnetter.
  """
  def main(ip_address, subnet_mask) do
    break_up_dotted_decimal(ip_address, subnet_mask)
    # |> convert_decimal_to_binary
    # |> measure_network_portion
    # |> calculate_subnet_range
    # |> convert_binary_to_dotted_decimal
  end

  def break_up_dotted_decimal(ip_address, subnet_mask) do
    ip_address_list = String.split(ip_address, ".")
    [ip_octet_1, ip_octet_2, ip_octet_3, ip_octet_4] = ip_address_list
    IO.puts(ip_octet_1)
    IO.puts(ip_octet_2)
    IO.puts(ip_octet_3)
    IO.puts(ip_octet_4)

    subnet_mask_list = String.split(subnet_mask, ".")
    [mask_octet_1, mask_octet_2, mask_octet_3, mask_octet_4] = subnet_mask_list
    IO.puts(mask_octet_1)
    IO.puts(mask_octet_2)
    IO.puts(mask_octet_3)
    IO.puts(mask_octet_4)

    IO.puts([ip_address_list, subnet_mask_list])
    [ip_address_list, subnet_mask_list]
  end
end
