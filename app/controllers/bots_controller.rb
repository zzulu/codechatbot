class BotsController < ApplicationController
  before_action :authenticate_user!
  before_action :connect_user!, except:[:account_connection]
  before_action :connected_user!, only:[:account_connection]
  before_action :get_bot, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, if: Proc.new {|c| c.request.format.json? }

  # GET /bots
  # GET /bots.json
  def index
    @bots = current_user.bots_with_templates
  end

  # GET /bots/1
  # GET /bots/1.json
  def show
  end

  # GET /bots/new
  def new
    @bot = current_user.bots.build
  end

  # POST /bots
  # POST /bots.json
  def create
    @bot = current_user.bots.new(bot_params)

    respond_to do |format|
      if @bot.save
        format.html { redirect_to @bot, notice: 'Bot was successfully created.' }
        format.json { render :show, status: :created, location: @bot }
      else
        format.html { render :new }
        format.json { render json: @bot.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /bots/1/edit
  def edit
  end

  # PATCH/PUT /bots/1
  # PATCH/PUT /bots/1.json
  def update
    @bot = @bot.fork(current_user) if @bot.user.id == 1 && current_user.id != 1
    respond_to do |format|
      if @bot.update(bot_params.except(:user_id))
        format.html { redirect_to @bot, notice: 'Bot was successfully updated.' }
        format.json { render :show, status: :ok, location: @bot }
      else
        format.html { render :edit }
        format.json { render json: @bot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bots/1
  # DELETE /bots/1.json
  def destroy
    @bot.destroy
    respond_to do |format|
      format.html { redirect_to bots_url, notice: 'Bot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def run_code
    ret = Bot.run_code(params[:code])
    render :json => {result: ret}
  end

  def account_connection
  end

  private
    def get_bot
      @bot = Bot.find(params[:id])
    end

    def bot_params
      params.require(:bot).permit(:prepend, :append, :message, :response)
    end

    def connect_user!
      redirect_to account_connection_path and return if current_user.user_key.nil?
    end

    def connected_user!
      redirect_to bots_path and return if current_user.user_key.present?
    end
end
