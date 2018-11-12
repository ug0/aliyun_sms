defmodule Aliyun.Sms do
  @moduledoc """
  Documentation for Aliyun.Sms.
  """

  import Aliyun.Util.Sign, only: [sign: 3, gen_nounce: 0]
  import Aliyun.Util.Time, only: [gen_timestamp: 0]

  @doc """
  发送短信.

  ## Examples

      Aliyun.Sms.send("1500000000", "sign", "template", %{code: "222333"})
      {:ok, %{"Code" => "OK", "Message" => "OK", ...}}
      {:error, %HTTPoison.Error{...}}
      {:error, %Jason.DecodeError{...}}
      {:error, code, %{"Code" => "isv.SMS_SIGNATURE_ILLEGAL", "Message" => "短信签名不合法"}}

  """
  @spec send(binary() | [binary()], binary(), binary(), map(), any(), any()) ::
          {:error, any()} | {:ok, map()} | {:error, any(), map()}
  def send(
        phones,
        sign_name,
        template,
        template_params \\ %{},
        up_extend_code \\ nil,
        out_id \\ nil
      )

  def send(phones, sign_name, template, template_params = %{}, up_extend_code, out_id) when is_list(phones) and length(phones) <= 1000 do
    send(Enum.join(phones, ","), sign_name, template, template_params, up_extend_code, out_id)
  end

  def send(phones, sign_name, template, template_params = %{}, up_extend_code, out_id) when is_binary(phones) do
    %{
      "PhoneNumbers" => phones,
      "SignName" => sign_name,
      "TemplateCode" => template,
      "TemplateParam" => Jason.encode!(template_params),
      "SmsUpExtendCode" => up_extend_code,
      "OutId" => out_id
    }
    |> build_request_params
    |> add_signature
    |> URI.encode_query()
    |> request()
  end

  defp request(query) do
    case HTTPoison.get("https://dysmsapi.aliyuncs.com/?" <> query) do
      {:ok, %HTTPoison.Response{body: body}} ->
        parse_response(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp parse_response(res_body) do
    case Jason.decode(res_body) do
      {:ok, data = %{"Code" => "OK"}} -> {:ok, data}
      {:ok, data = %{"Code" => err_code}} -> {:error, err_code, data}
      {:error, error = %Jason.DecodeError{}} -> {:error, error}
    end
  end

  defp add_signature(params) do
    params
    |> Map.merge(%{
      "Signature" => sign("GET", params, access_key_secret() <> "&")
    })
  end

  defp build_request_params(params) do
    sys_params()
    |> Map.merge(business_params())
    |> Map.merge(params)
    |> Stream.reject(fn {_, v} -> is_nil(v) end)
    |> Enum.into(%{})
  end

  defp business_params do
    %{
      "Action" => "SendSms",
      "Version" => "2017-05-25",
      "RegionId" => "cn-hangzhou",
      "phoneNumbers" => nil,
      "SignName" => nil,
      "TemplateCode" => nil,
      "TemplateParam" => nil,
      "OutId" => nil
    }
  end

  defp sys_params do
    %{
      "AccessKeyId" => access_key_id(),
      "Timestamp" => gen_timestamp(),
      "Format" => "JSON",
      "SignatureMethod" => "HMAC-SHA1",
      "SignatureVersion" => "1.0",
      "SignatureNonce" => gen_nounce(),
      "Signature" => nil
    }
  end

  defp access_key_id do
    Application.get_env(:aliyun_sms, :access_key_id)
  end

  defp access_key_secret do
    Application.get_env(:aliyun_sms, :access_key_secret)
  end
end
