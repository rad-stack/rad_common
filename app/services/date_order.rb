class DateOrder
  def self.invalid_date_order?(start_date, end_date)
    (start_date.present? && end_date.present?) && (start_date > end_date)
  end
end
