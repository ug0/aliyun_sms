# AliyunSms

[![Build Status](https://travis-ci.org/ug0/aliyun_sms.svg?branch=master)](https://travis-ci.org/ug0/aliyun_sms)
[![Hex.pm](https://img.shields.io/hexpm/v/aliyun_sms.svg)](https://hex.pm/packages/aliyun_sms)

Aliyun SMS API(阿里云短信服务 API)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `aliyun_sms` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:aliyun_sms, "~> 0.2.4"}
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
Aliyun.Sms.send_sms("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
# {:ok, %{"Code" => "OK", "Message" => "OK", "BizId" => "700000000000000000^0", "RequestId" => "A0000000-3CC1-4000-8000-E00000000000"}}

Aliyun.Sms.send_sms("1500000000", "invalid_sig", "SMS_0000", %{code: "222333"})
# {:error, "isv.SMS_SIGNATURE_ILLEGAL", %{"Code" => "isv.SMS_SIGNATURE_ILLEGAL", "Message" => "短信签名不合法"}}

Aliyun.Sms.send_sms("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
# {:error, :http_error, "REASON"}

Aliyun.Sms.send_sms("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
# {:error, :json_decode_error, "BODY"}
```


Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/aliyun_sms](https://hexdocs.pm/aliyun_sms).

