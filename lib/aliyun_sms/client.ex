defmodule Aliyun.Sms.Client do
  alias Aliyun.Sms.Request
  alias Aliyun.Sms.Response

  @doc """
  发送短信.

  ## Examples

      iex> Aliyun.Sms.Client.send("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:ok, %{"Code" => "OK", "Message" => "OK", ...}}

      iex> Aliyun.Sms.Client.send("1500000000", "invalid_sig", "SMS_0000", %{code: "222333"})
      {:error, code, %{"Code" => "isv.SMS_SIGNATURE_ILLEGAL", "Message" => "短信签名不合法"}}

      iex> Aliyun.Sms.Client.send("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:error, :http_error, reason}

      iex> Aliyun.Sms.Client.send("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:error, :json_decode_error, body}

  """
  @type error_code() :: :http_error | :json_decode_error | String.t()
  @spec send_sms(String.t(), String.t(), String.t(), map(), String.t() | nil, String.t() | nil) ::
          {:ok, map()} | {:error, error_code(), String.t()}

  def send_sms(phones, sign_name, template, template_params = %{}, up_extend_code \\ nil, out_id \\ nil) do
    %{
      "PhoneNumbers" => phones,
      "SignName" => sign_name,
      "TemplateCode" => template,
      "TemplateParam" => Jason.encode!(template_params),
      "SmsUpExtendCode" => up_extend_code,
      "OutId" => out_id
    }
    |> Request.build_query()
    |> request()
  end

  defp request(query) do
    case HTTPoison.get("https://dysmsapi.aliyuncs.com/?" <> query) do
      {:ok, %HTTPoison.Response{body: body}} ->
        Response.parse(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, :http_error, reason}
    end
  end
end
