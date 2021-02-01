defmodule Aliyun.Sms.Client do
  alias Aliyun.Sms.Request
  alias Aliyun.Sms.Response

  @doc """
  发送短信.

  ## Examples

      iex> Aliyun.Sms.Client.send_sms("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:ok, %{"Code" => "OK", "Message" => "OK", "BizId" => "700000000000000000^0", "RequestId" => "A0000000-3CC1-4000-8000-E00000000000"}}

      iex> Aliyun.Sms.Client.send_sms("1500000000,1500000001", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:ok, %{"Code" => "OK", "Message" => "OK", "BizId" => "700000000000000000^0", "RequestId" => "A0000000-3CC1-4000-8000-E00000000000"}}

      iex> Aliyun.Sms.Client.send_sms(["1500000000", "1500000001"], "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:ok, %{"Code" => "OK", "Message" => "OK", "BizId" => "700000000000000000^0", "RequestId" => "A0000000-3CC1-4000-8000-E00000000000"}}

      iex> Aliyun.Sms.Client.send_sms("1500000000", "invalid_sig", "SMS_0000", %{code: "222333"})
      {:error, "isv.SMS_SIGNATURE_ILLEGAL", %{"Code" => "isv.SMS_SIGNATURE_ILLEGAL", "Message" => "短信签名不合法"}}

      iex> Aliyun.Sms.Client.send_sms("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:error, :http_error, "REASON"}

      iex> Aliyun.Sms.Client.send_sms("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
      {:error, :json_decode_error, "BODY"}

  """
  @type error_code() :: :http_error | :json_decode_error
  @spec send_sms(String.t() | [String.t()], String.t(), String.t(), map(), String.t() | nil, String.t() | nil) ::
          {:ok, map()} | {:error, String.t(), map()} | {:error, error_code(), String.t()}

  def send_sms(phones, sign_name, template, template_params, up_extend_code \\ nil, out_id \\ nil)

  def send_sms(phones = [_ | _], sign_name, template, template_params, up_extend_code, out_id) do
    phones
    |> Enum.join(",")
    |> send_sms(sign_name, template, template_params, up_extend_code, out_id)
  end

  def send_sms(phones, sign_name, template, template_params = %{}, up_extend_code, out_id) do
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
