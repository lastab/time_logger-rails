class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  # def index
  #   @timelogs = Timelog.all
  # end

  # def create
  #   respond_to do |format|
  #     format.json do
  #       @timelog = Timelog.new(start_at: params[:start_at], end_at: params[:end_at])
  #       if @timelog.save
  #         render json: {}, status: :ok
  #       else
  #         render json: {}, status: :bad_request
  #       end
  #     end
  #   end
  # end
end
