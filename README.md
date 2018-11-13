# AliyunSms

![Hex.pm](https://img.shields.io/hexpm/v/aliyun_sms.svg)

Aliyun SMS API(阿里云短信服务 API)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `aliyun_sms` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:aliyun_sms, "~> 0.1.0"}
  ]
end
```

## Configuration
```elixir
config :aliyun_sms,
  access_key_id: "ALIYUN_ACCESS_KEY_ID",
  access_key_secret: "ALIYUN_ACCESS_KEY_SECRET"
```

## Usage

```elixir
Aliyun.Sms.send("1500000000", "sign", "template", %{code: "222333"})
# {:ok, %{"Code" => "OK", "Message" => "OK", ...}}
# {:error, %HTTPoison.Error{...}}
# {:error, %Jason.DecodeError{...}}
# {:error, code, %{"Code" => "isv.SMS_SIGNATURE_ILLEGAL", "Message" => "短信签名不合法"}}
```


Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/aliyun_sms](https://hexdocs.pm/aliyun_sms).

