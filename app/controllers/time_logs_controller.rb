class TimeLogsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, only: [:start, :end, :notify_slack]
  def index
    @timelogs = Timelog.all
    # notifier = Slack::Notifier.new ENV["SLACK_URL"]
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
end
