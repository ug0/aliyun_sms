defmodule Aliyun.Sms.Client do
  @doc """
  发送短信.

  ## Examples

      iex> Aliyun.Sms.Client.send_sms("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:ok, %{"Code" => "OK", "Message" => "OK", "BizId" => "700000000000000000^0", "RequestId" => "A0000000-3CC1-4000-8000-E00000000000"}}

      iex> Aliyun.Sms.Client.send_sms("1500000000", "invalid_sig", "SMS_0000", %{code: "222333"})
      {:error, %{"Code" => "isv.SMS_SIGNATURE_ILLEGAL", "Message" => "短信签名不合法"}}

      iex> Aliyun.Sms.Client.send_sms("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:error, %Req.TransportError{reason: :ehostunreach}}
  """
  def send_sms(phones, sign_name, template, template_params = %{}, up_extend_code \\ nil, out_id \\ nil) do
    request(
      %{
        "PhoneNumbers" => phones,
        "SignName" => sign_name,
        "TemplateCode" => template,
        "TemplateParam" => JSON.encode!(template_params),
        "SmsUpExtendCode" => up_extend_code,
        "OutId" => out_id
      }
    )
  end

  @headers %{
    "x-acs-action" => "SendSms",
    "x-acs-version" => "2017-05-25"
  }
  @url "https://dysmsapi.aliyuncs.com/"
  defp request(query_params) do
    config = Aliyun.Util.Config.new!(%{access_key_id: access_key_id(), access_key_secret: access_key_secret()})
    headers = Map.merge(@headers, %{
      "x-acs-date" => Aliyun.Util.Time.gmt_now_iso8601(),
      "x-acs-signature-nonce" => :crypto.strong_rand_bytes(16) |> Base.encode16() |> String.downcase()
    })

    config
    |> Aliyun.Util.Request.build!(:post, @url, query_params, headers, "")
    |> Aliyun.Util.Request.request()
    |> parse_response()
  end

  defp parse_response({:ok, %{body: %{"Code" => "OK"} = body}}) do
    {:ok, body}
  end

  defp parse_response({:ok, %{body: %{} = body}}) do
    {:error, body}
  end

  defp parse_response({:error, error}) do
    {:error, error}
  end

  defp access_key_id do
    Confex.get_env(:aliyun_sms, :access_key_id)
  end

  defp access_key_secret do
    Confex.get_env(:aliyun_sms, :access_key_secret)
  end
end
