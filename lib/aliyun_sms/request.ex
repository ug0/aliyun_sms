defmodule Aliyun.Sms.Request do
  import Aliyun.Util.Sign, only: [sign: 3, gen_nounce: 0]
  import Aliyun.Util.Time, only: [gen_timestamp: 0]

  @spec build_query(map()) :: String.t()
  def build_query(params = %{}) do
    params
    |> build_request_params()
    |> add_signature()
    |> URI.encode_query()
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
    Confex.get_env(:aliyun_sms, :access_key_id)
  end

  defp access_key_secret do
    Confex.get_env(:aliyun_sms, :access_key_secret)
  end
end
