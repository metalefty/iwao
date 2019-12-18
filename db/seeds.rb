# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
  # 自動生成するRADIUSユーザ名のprefix
  [:radius_username_prefix, 'iw_'],
  # 自動生成するRADIUSユーザ名のsuffix
  [:radius_username_suffix, '@guest.example.jp'],
  # 利用申請を承認する管理者のメールアドレス
  [:administrator_email,    'administrator@example.com'],
  # IWAOシステムからメールを送信するときの送信元(from)
  [:email_sender,           'guest_registration@example.jp'],
  # 利用登録通知メールの件名 (管理者向け)
  [:email_subject_request_for_approval, '[IWAO] 新規登録がありました'],
  # 利用登録通知メールの件名 (利用者向け)
  [:email_subject_registration_receipt, 'ゲストWi-Fi利用登録を受け付けました'],
  # 利用登録通知メールの件名 (利用者向け)
  [:email_subject_registration_approved, 'ゲストWi-Fi利用登録が承認されました'],
  # IWAOシステムで発行したアカウントで接続できるSSID
  [:wifi_ssid,              'haw-guest'],
  # 登録フォームの上に表示される注釈 (HTML)
  [:new_guest_reg_note, <<-"EOS"
<p>新規登録画面の登録ボタンの上に表示する内容は、IwaoConfigの:new_guest_reg_noteで設定します。</p>
<p>入力された個人情報は、ゲストWi-Fiのアカウント発行のために使用します。</p>
<p>接続用パスワードはメールで送信されます。スマートフォン等で受信できるメールアドレスを入力してください。</p>
   EOS
  ]
].each do |name, content|
  i = IwaoConfig.find_or_initialize_by(name: name)
  i.update_attributes(content: content) if i.new_record?
end
