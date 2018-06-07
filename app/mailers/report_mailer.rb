class ReportMailer < ApplicationMailer
  default from: '"チケッター" <tktter.com@gmail.com>'   # 送信元アドレス
  default to: '"チケッター" <tktter.com@gmail.com>'     # 送信先アドレス

  def received_email(report)
    @report = report
    mail(:subject => 'お問い合わせを承りました')
  end
end
