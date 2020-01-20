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
  # 登録フォームの上に表示される注釈 (Markdown)
  [
    [:new_guest_reg_note, <<-"EOS"
入力及び登録は原則、ご利用になるご本人が行ってください。

資格情報(パスワード等)はメールで送信されます。確実に資格情報を受信できるよう、必要に応じて
スマートフォン等で受信できる予備メールアドレスを入力してください。
    EOS
    ]
  ],
  [:term_of_service, <<-"EOS"

本利用規約は、株式会社○○（以下「当社」）がゲスト向けに
提供するWi-Fiサービスの利用について、必要な事項を定めるものです。

1. 本システムが発行する資格情報は利用登録を完了した本人に対して発行するもの
   です。発行された資格情報を利用者本人以外に開示することや、利用者本人以外
   が使用することは禁止します。

2. 本サービスを利用して、公序良俗や法令に違反する行為を行ってはなりません。

3. 本サービスの利用によって第三者に対して損害を与えた場合、利用者は自己の
   責任と費用をもって解決しなければなりません。

4. 本サービスでは、WPA2 Enterprise方式で無線区間の通信を保護していますが
   利用者は自己の責任において暗号化通信を使用し、通信内容の保護を行って
   ださい。

5. 当社はネットワークの保守、管理及び利用状況の確認のため、利用者の接続
   時刻、接続時間、利用端末のMACアドレス等の情報（以下「接続状況」）を記録
   します。

6. 入力された個人情報及び前項の接続状況は、当社にて適切に管理し第三者へ開示
   することはありません。ただし、法令に基づき、捜査機関等から要求された場合
   はこの限りではありません。

7. 発行された資格情報を使用してゲストWi-Fiに接続した時点で、上記の利用規約
   すべてに同意したものとみなします。
   EOS
  ]
].each do |name, content|
  i = IwaoConfig.find_or_initialize_by(name: name)
  i.update_attributes(content: content) if i.new_record?
end
