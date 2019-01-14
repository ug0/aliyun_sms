defmodule Aliyun.Sms do
  @doc """
  发送短信.

  ## Examples

      iex> Aliyun.Sms.send("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:ok, %{"Code" => "OK", "Message" => "OK", ...}}

      iex> Aliyun.Sms.send("1500000000", "invalid_sig", "SMS_0000", %{code: "222333"})
      {:error, code, %{"Code" => "isv.SMS_SIGNATURE_ILLEGAL", "Message" => "短信签名不合法"}}

      iex> Aliyun.Sms.send("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:error, :http_error, reason}

      iex> Aliyun.Sms.send("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:error, :json_decode_error, body}

  """
  @type error_code() :: :http_error | :json_decode_error | String.t()
  @spec send_sms(String.t(), String.t(), String.t(), map(), String.t() | nil, String.t() | nil) ::
          {:ok, map()} | {:error, error_code(), String.t()}

  defdelegate send_sms(phones, sign_name, template, template_params, up_extend_code \\ nil, out_id \\ nil), to: Aliyun.Sms.Client
end
