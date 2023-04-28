# frozen_string_literal: true

module ApplicationHelper
  def default_meta_tags
    {
      site: 'Subsc.mine',
      reverse: true,
      charset: 'utf-8',
      description: 'Subsc.mineは複数のサブスクリプションサービスを契約している人向けの、利用サブスク一覧ツールです。',
      og: {
        title: :title,
        type: 'website',
        site_name: 'Subsc.mine',
        description: :description,
        image: image_url('OGP.png'),
        url: 'https://subsc-mine.fly.dev/'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@maimux2x'
      }
    }
  end
end
