require "rails_helper"

describe ContactMailer do
  let(:contact){FactoryBot.build(:contact)}

  describe'send mail' do
    subject(:mail) do
      described_class.contact_mail(contact).deliver_now
      ActionMailer::Base.deliveries.last
    end

    context 'when contact_mail' do
      it { expect(mail.to.first).to eq(ENV['EMAIL_ADDRESS']) }
      it { expect(mail.subject).to eq('お問い合わせ')}
      it { expect(mail.body).to match("test@example.com") }
    end
  end
end
