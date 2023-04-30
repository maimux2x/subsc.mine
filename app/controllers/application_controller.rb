# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate
  helper_method :logged_in?, :current_user

  unless Rails.env.development?
    rescue_from Exception, with: :_render500
    rescue_from ActiveRecord::RecordNotFound, with: :_render404
    rescue_from ActionController::RoutingError, with: :_render404
  end

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  private

  def logged_in?
    !!current_user
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticate
    return if logged_in?

    redirect_to root_path, notice: "ログインしてください"
  end

  def _render404(err = nil)
    logger.info "Rendering 404 with exception: #{err.message}" if err

    if request.format.to_sym == :json
      render json: { error: '404 Not Found' }, status: :not_found
    else
      render 'errors/404', status: :not_found
    end
  end

  def _render500(err = nil)
    logger.error "Rendering 500 with exception: #{err.message}" if err

    if request.format.to_sym == :json
      render json: { error: '500 Internal Server Error' }, status: :internal_server_error
    else
      render 'error/500', status: :internal_server_error, layout: 'error'
    end
  end
end
