require 'rails_helper'

RSpec.describe SubscriptionsInIcalFormatExporter, type: :model do
  it 'check to export correct user subscriptions' do
    travel_to Time.zone.local(2023, 0o4, 0o1) do
      user = create(:user)
      other_user = create(:user)
      create(:subscription, user:, name: '継続中のデータ', subscribed: true)
      create(:subscription, user:, name: '停止中のデータ', subscribed: false)
      create(:subscription, user: other_user, name: '別ユーザーのデータ', subscribed: true)
      subscriptions = Subscription.where(user_id: user.id, subscribed: true)

      calendar = SubscriptionsInIcalFormatExporter.export_subscriptions(subscriptions)
      calendar.publish
      expect(calendar.to_ical).to include('継続中のデータ')
      expect(calendar.to_ical).not_to include('停止中のデータ')
      expect(calendar.to_ical).not_to include('別ユーザーのデータ')
    end
  end
end
