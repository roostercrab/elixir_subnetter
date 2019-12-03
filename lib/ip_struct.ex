defmodule IPStruct do
  defstruct original_ip_address: nil,
            original_subnet_mask: nil,
            ip_address_list: nil,
            subnet_mask_list: nil,
            first_ip_octet_binary: nil,
            second_ip_octet_binary: nil,
            third_ip_octet_binary: nil,
            fourth_ip_octet_binary: nil,
            first_mask_octet_binary: nil,
            second_mask_octet_binary: nil,
            third_mask_octet_binary: nil,
            fourth_mask_octet_binary: nil
end
