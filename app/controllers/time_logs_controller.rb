class TimeLogsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, only: [:start, :end, :notify_slack]
  def index
    @timelogs = Timelog.all
    if params[:date]
      start_time = Time.parse(params[:date]).beginning_of_day
      end_time  = start_time.end_of_day
      @timelogs = @timelogs.where(start_at: [start_time...end_time])
    end
    # @timelogs = @timelogs.where

    @timelogs = @timelogs.paginate(page: params[:page], per_page: 15)
  end

  def start
    render JSON: {}, status: :ok
  end

  def end
    respond_to do |format|
      format.json do
        @timelog = Timelog.new(start_at: params[:start_at], end_at: params[:end_at])
        if @timelog.save
          render json: {}, status: :ok
        else
          render json: {}, status: :bad_request
        end
      end
    end
  end

  def slack_notification
    @timelogs = Timelog.where(start_at: [(Time.now - 1.day)..Time.now])
    minutes = @timelogs.inject(0) { |sum, x| sum + x.duration }
    hours = minutes / 60
    remainder_minutes = minutes % 60

    message = "In last 24 hours, standing table was used for #{hours} hours and #{remainder_minutes} minutes only."
    message = "Standing Table was not used at all in last 24 hours." if @timelogs.length == 0
    notifier = Slack::Notifier.new ENV["SLACK_URL"]

    notifier.ping message, channel: '#random'

    render nothing: true
  end
end
