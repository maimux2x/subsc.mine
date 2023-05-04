# frozen_string_literal: true

module ApplicationHelper
  def default_meta_tags
    {
      site: 'サブスクの次回お支払日を管理 Subsc.mine',
      reverse: true,
      charset: 'utf-8',
      description: 'Subsc.mineは複数のサブスクリプションサービスを契約している人向けの、利用サブスク一覧ツールです。',
      og: {
        title: :title,
        type: 'website',
        site_name: 'Subsc.mine',
        description: :description,
        image: image_url('OGP.jpg'),
        url: 'https://subsc-mine.com/'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@maimux2x'
      }
    }
  end
end
