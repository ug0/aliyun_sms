defmodule Aliyun.Sms do
  @doc """
  发送短信.

  ## Examples

      iex> Aliyun.Sms.send_sms("1500000000", "阿里云短信测试专用", "SMS_0000", ~s[{"code":"222333"}])
      {:ok, %{"Code" => "OK", "Message" => "OK", "BizId" => "700000000000000000^0", "RequestId" => "A0000000-3CC1-4000-8000-E00000000000"}}

      iex> Aliyun.Sms.send_sms("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:ok, %{"Code" => "OK", "Message" => "OK", "BizId" => "700000000000000000^0", "RequestId" => "A0000000-3CC1-4000-8000-E00000000000"}}

      iex> Aliyun.Sms.send_sms("1500000000", "invalid_sig", "SMS_0000", %{code: "222333"})
      {:error, %{"Code" => "isv.SMS_SIGNATURE_ILLEGAL", "Message" => "短信签名不合法"}}

      iex> Aliyun.Sms.send_sms("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:error, %Req.TransportError{reason: :ehostunreach}}

  """
  @spec send_sms(String.t(), String.t(), String.t(), map() | String.t(), String.t() | nil, String.t() | nil) ::
          {:ok, map()} | {:error, map()}

  defdelegate send_sms(phones, sign_name, template, template_params, up_extend_code \\ nil, out_id \\ nil), to: Aliyun.Sms.Client
end
