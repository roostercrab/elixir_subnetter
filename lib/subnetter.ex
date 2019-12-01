defmodule Subnetter do
  @moduledoc """
  Documentation for Subnetter.
  """
  def get_address_and_mask do
    ip_address = IO.gets("What is the IP address?")
    subnet_mask = IO.gets("What is the subnet mask?")
    IO.puts(ip_address)
    IO.puts(subnet_mask)
  end
end
