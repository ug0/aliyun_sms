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
    {:aliyun_sms, "~> 0.2.8"}
  ]
end
```

## Configuration
```elixir
config :aliyun_sms,
  access_key_id: "ALIYUN_ACCESS_KEY_ID",
  access_key_secret: "ALIYUN_ACCESS_KEY_SECRET"
```
Or if you want to config them via run-time system environment variables:
```elixir
config :aliyun_sms,
  access_key_id: {:system, "ALIYUN_ACCESS_KEY_ID"},
  access_key_secret: {:system, "ALIYUN_ACCESS_KEY_SECRET"}
```


## Quickstart

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

## Documentation
- [https://hexdocs.pm/aliyun_sms](https://hexdocs.pm/aliyun_sms)

- [阿里云官方文档](https://help.aliyun.com/document_detail/102715.html?spm=a2c4g.11186623.2.9.64da5f30jYcBMx#concept-t4w-pcs-ggb)

| Aliyun | Description | This package |
| ---------- | ----------- | --------------- |
| SendSMS    | 发送短信。    | `Aliyun.Sms.send_sms/6` |
| SendBatchSms | 批量发送短信。| [TODO] |
| QuerySendDetails | 查询短信发送的状态。 | [TODO] |
| AddSmsSign | 调用短信AddSmsSign申请短信签名。 | [TODO] |
| DeleteSmsSign | 调用接口DeleteSmsSign删除短信签名。 | [TODO] |
| QuerySmsSign | 调用接口QuerySmsSign查询短信签名申请状态。 | [TODO] |
| ModifySmsSign | 调用接口ModifySmsSign修改未审核通过的短信签名，并重新提交审核。 | [TODO] |
| ModifySmsTemplate |	调用接口ModifySmsTemplate修改未通过审核的短信模板。 | [TODO] |
| QuerySmsTemplate |	调用接口QuerySmsTemplate查询短信模板的审核状态。 | [TODO] |
| AddSmsTemplate |	调用接口AddSmsTemplate申请短信模板。 | [TODO] |
| DeleteSmsTemplate |	调用接口DeleteSmsTemplate删除短信模板。 | [TODO] |