# AliyunSms

[![Run Tests](https://github.com/ug0/aliyun_sms/actions/workflows/test.yml/badge.svg)](https://github.com/ug0/aliyun_sms/actions/workflows/test.yml)
[![Publish](https://github.com/ug0/aliyun_sms/actions/workflows/publish.yml/badge.svg)](https://github.com/ug0/aliyun_sms/actions/workflows/publish.yml)
[![Module Version](https://img.shields.io/hexpm/v/aliyun_sms.svg)](https://hex.pm/packages/aliyun_sms)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/aliyun_sms/)
[![Total Download](https://img.shields.io/hexpm/dt/aliyun_sms.svg)](https://hex.pm/packages/aliyun_sms)
[![License](https://img.shields.io/hexpm/l/aliyun_sms.svg)](https://github.com/ug0/aliyun_sms/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/ug0/aliyun_sms.svg)](https://github.com/ug0/aliyun_sms/commits/master)

Aliyun SMS API(阿里云短信服务 API)

## Installation
Add `:aliyun_sms` to the list of dependencies in `mix.exs`:

> **NOTE:** v0.3.x requires Elixir version greater than v1.18

```elixir
def deps do
  [
    {:aliyun_sms, "~> 0.3.0"}
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
Aliyun.Sms.send_sms("1500000000", "阿里云短信测试专用", "SMS_0000", ~s[{"code":"222333"}])
# {:ok, %{"Code" => "OK", "Message" => "OK", "BizId" => "700000000000000000^0", "RequestId" => "A0000000-3CC1-4000-8000-E00000000000"}}

Aliyun.Sms.send_sms("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
# {:ok, %{"Code" => "OK", "Message" => "OK", "BizId" => "700000000000000000^0", "RequestId" => "A0000000-3CC1-4000-8000-E00000000000"}}

Aliyun.Sms.send_sms("1500000000", "invalid_sig", "SMS_0000", %{code: "222333"})
# {:error, %{"Code" => "isv.SMS_SIGNATURE_ILLEGAL", "Message" => "短信签名不合法"}}

Aliyun.Sms.send_sms("1500000000", "阿里云短信测试专用", "SMS_0000", %{code: "222333"})
# {:error, %Req.TransportError{reason: :ehostunreach}}
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