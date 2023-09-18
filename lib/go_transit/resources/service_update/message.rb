module GoTransit
  class ServiceUpdate::Message < ApiResource
    attr_accessor :code, :parent_code, :status, :posted_date_time,
                  :subject_english, :subject_french, :body_english,
                  :body_french, :category, :sub_category, :lines, :stops, :trips

    def posted_date_time_utc
      to_utc(posted_date_time)
    end
  end
end
