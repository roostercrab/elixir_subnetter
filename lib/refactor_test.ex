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
      {ip_octet_1, ip_octet_2, ip_octet_3, ip_octet_4} = ip_address
      IO.puts(ip_octet_1)
      IO.puts(ip_octet_2)
      IO.puts(ip_octet_3)
      IO.puts(ip_octet_4)
  end
end
