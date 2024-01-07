class Reservation < ApplicationRecord
  belongs_to :user
  
  validates :day, presence: true
  validates :time, presence: true
  validates :start_time, presence: true, uniqueness: true
  
  validates :date_before_start
  validates :date_current_today
  validates :date_three_month_end
  
  def date_before_start
    errors.add(:day, "は過去の日付は選択できません。予約画面から正しい日付を選択してください。") if day < Date.current
  end
  
  def date_current_today
    errors.add(:day, "当日は選択できません。予約画面から正しい日付を選択してください。") if day < (Date.current + 1)
  end
  
  def date_three_month_end
    errors.add(:day, "は3か月以降の日付は選できません。予約画面から正しい日付を選択してください。") if (Date.current >> 3) < day
  end
  
  def self.check_reservation_day(dsay)
    if day < Date.current
      return "過去の日付は選択できません。正しい日付を選択してください。"
    elseif day < (Date.current + 1)
      return "当日は選択できません。正しい日付を選択してください。"
    elseif (Date.current >> 3) < day
      return "3か月以降の日付は選択できません。正しい日付を選択してください。"
    end
  end
  
  def self.reservations_after_three_month
    reservations = Resertation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
    reservation_date = []
    reservation.each do |reservation|
    reservation_hash = {}
    reservation_hash.merge!(day: reservation.day.starttime("%Y-%m-%d"), time: reservation.time)
    reservation_data.push(reservations_hash)
    end
  reservation_data
  end
end
