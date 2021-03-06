defmodule Aliyun.Sms.Response do
  @doc ~S"""
  Parse response body

  ## Examples

    iex> Aliyun.Sms.Response.parse("{\"Message\":\"OK\",\"RequestId\":\"9AFF0000-1B1B-2222-AA66-DD0000000000\",\"BizId\":\"965000000000000000^0\",\"Code\":\"OK\"}")
    {:ok,
     %{
       "BizId" => "965000000000000000^0",
       "Code" => "OK",
       "Message" => "OK",
       "RequestId" => "9AFF0000-1B1B-2222-AA66-DD0000000000"
     }}
  """
  @type error_code() :: :json_decode_error | String.t()
  @spec parse(String.t()) ::
          {:ok, map()}
          | {:error, error_code(), String.t()}
  def parse(data) do
    case Jason.decode(data) do
      {:ok, %{"Code" => "OK"} = parsed_data} -> {:ok, parsed_data}
      {:ok, %{"Code" => err_code} = parsed_data} -> {:error, err_code, parsed_data}
      {:error, %Jason.DecodeError{}} -> {:error, :json_decode_error, data}
    end
  end
end
