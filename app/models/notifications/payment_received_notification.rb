module Notifications
  class PaymentReceivedNotification < ::NotificationType
    def mailer_subject
      "Payment Received from #{client_name} (#{formatted_amount})"
    end

    def mailer_message
      "A payment of #{formatted_amount} was received from #{client_name} on #{payment.transaction_date}. " \
        "Stripe Charge ID: #{payment.stripe_charge_id}. Please review the payment record for further details."
    end

    def subject_url
      Rails.application.routes.url_helpers.payment_url(payment)
    end

    private

      def payment
        subject_record
      end

      def client_name
        payment.client.name
      end

      def formatted_amount
        ActiveSupport::NumberHelper.number_to_currency(payment.amount)
      end
  end
end
