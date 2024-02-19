module BxBlockAdmin
  class DashboardsController < ApplicationController
    before_action :current_user
    require 'date'
    def user_counts
      users = AccountBlock::Account.where.not(jwt_token: nil)
      android_user_counts = users.android.count
      ios_user_counts = users.ios.count
      render json: {data: {ios_user_counts: ios_user_counts, android_user_counts: android_user_counts}},
      status: :ok
    end

    def advertisement_counts
      advertisements = BxBlockCatalogue::Advertisement.all
      render json: {data: advertisements.map{|ad| {url: ad.url, count: ad.page_clicks.sum(:click_count)}}},
      status: :ok
    end

    def login_time
      if params[:start_date] && params[:end_date]
        start_date = params[:start_date].to_date
        end_date = params[:end_date].to_date
        login_data = AccountBlock::ActiveHour.where("created_at::Date between '#{params[:start_date].to_date}' and '#{params[:end_date].to_date}'")
      else
        year = Date.today.strftime("%Y").to_i
        month = Date.today.strftime("%m").to_i
        start_date = Date.new(year, month, 1).to_date
        end_date = Date.today.at_beginning_of_month.next_month.to_date
        login_data = AccountBlock::ActiveHour.where("created_at::Date between '#{start_date}' and '#{end_date}'")
      end
      login_time_data = Hash.new
      gg_hrs = 0
      eg_hrs = 0
      fu_hrs = 0
      gg_flag = 0
      eg_flag = 0
      fu_flag = 0
      gg_hr = 0
      eg_hr = 0
      fu_hr = 0
      days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      slots = ['0-4', '4-8', '8-12', '12-16', '16-20', '20-24']
      users = ['free_user' ,'glow_getter', 'elite_glow_getter']
      users.each do |i|
        login_time_data[i] = Array.new
        (0..6).each do |j|
          login_time_data[i][j] = Hash.new
          login_time_data[i][j]['value'] = 0
          login_time_data[i][j]['label'] = days[j]
          login_time_data[i][j]['yAxisLabelText'] = '00:00'
          login_time_data[i][j]['total'] = 0
          login_time_data[i][j]['count'] = 0
        end
      end

      login_data.each do |data|
        account = AccountBlock::Account.find(data.account_id)
        if account.membership_plan[:plan_type] == "glow_getter"
          user = 'glow_getter'
          gg_hrs += (data.to.present?) ? (data.to - data.from).to_f / 60 : (Time.now - data.from).to_f / 60
          gg_flag = gg_flag + 1
        elsif account.membership_plan[:plan_type] == "elite"
          user = 'elite_glow_getter'
          eg_hrs += (data.to.present?) ? (data.to - data.from).to_f / 60 : (Time.now - data.from).to_f / 60
          eg_flag = eg_flag + 1
        elsif account.membership_plan[:plan_type] == "free" || account&.role&.name.downcase == "user"
          user = 'free_user'
          fu_hrs += (data.to.present?) ? (data.to - data.from).to_f / 60 : (Time.now - data.from).to_f / 60
          fu_flag = fu_flag + 1
        else
          break;
        end

        users.each do |usr|
          (0..6).each do |index|
            if user == usr
              if data.created_at.strftime("%a") == days[index]
                if login_time_data[user][index]['total'] == 0
                  login_time_data[user][index]['total'] = data.created_at.strftime("%k").to_i
                  login_time_data[user][index]['count'] = 1
                else
                  login_time_data[user][index]['total'] += data.created_at.strftime("%k").to_i
                  login_time_data[user][index]['count'] += 1
                end
              end
            end
            login_time_data[user][index]['value'] = login_time_data[user][index]['total'] / login_time_data[user][index]['count'] if login_time_data[user][index]['count'] != 0
            avg_time = login_time_data[user][index]['value']
            if avg_time >= 0 and avg_time < 4
              slot = '00:00'
            elsif avg_time >= 4 and avg_time < 8
              slot = '04:00'
            elsif avg_time >= 8 and avg_time < 12
              slot = '08:00'
            elsif avg_time >= 12 and avg_time < 16
              slot = '12:00'
            elsif avg_time >= 16 and avg_time < 20
              slot = '16:00'
            elsif avg_time >= 20
              slot = '20:00'
            end
            login_time_data[user][index]['yAxisLabelText'] = slot
          end
        end
      end
      users.each do |i|
        (0..6).each do |j|
          login_time_data[i][j].delete('total')
          login_time_data[i][j].delete('count')
        end
      end
      gg_hr = (gg_hrs/gg_flag) / 60 if gg_flag != 0
      eg_hr = (eg_hrs/eg_flag) / 60 if eg_flag != 0
      fu_hr = (fu_hrs/fu_flag) / 60 if fu_flag != 0
      
      render json: {data: login_time_data, elite_glow_getter_hours: '%.2f' % eg_hr, glow_getter_hours: '%.2f' % gg_hr, free_user_hours: '%.2f' % fu_hr}, status: :ok
    end
  end
end
