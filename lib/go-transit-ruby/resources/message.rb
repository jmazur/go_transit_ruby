module GoTransit
  class Message < ApiObject
    attr_accessor :code, :parent_code, :status, :posted_date_time,
                  :subject_english, :subject_french, :body_english,
                  :body_french, :category, :sub_category

    # has partial lines, stops, and trips

  end
end
